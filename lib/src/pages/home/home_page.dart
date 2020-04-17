import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/utils/ui_utils.dart';

import '../../locator.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    _verifyLogin();
  }

  void _verifyLogin() async {
    final isLoggedIn = await locator<AuthService>().isUserLoggedIn();
    if (!isLoggedIn)
      locator<NavigationService>().navigateToClearStack(loginRoute);
    else
      _verifyEmail();
  }

  void _verifyEmail() async {
    final isEmailVerified = await locator<AuthService>().isEmailVerified();
    if (!isEmailVerified)
      locator<NavigationService>().navigateTo(emailVerificationRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => locator<NavigationService>().navigateTo(addNote),
      ),
      body: SafeArea(child: HomePageLayout()),
    );
  }
}

class HomePageLayout extends StatelessWidget {
  void _signOut(BuildContext context) {
    locator<AuthService>()
        .signOut()
        .then((value) =>
            locator<NavigationService>().navigateToClearStack(loginRoute))
        .catchError((e) => showMessage(context, e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => {},
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () => _signOut(context),
              ),
            ],
          ),
          NoteList(),
        ],
      ),
    );
  }
}

class NoteList extends StatelessWidget {
  int _crossAxisCount(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    if (screenSize > 1000) return 5;
    if (screenSize > 800) return 4;
    if (screenSize > 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final userId = locator<AuthService>().firebaseUser.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: locator<DatabaseService>().getNotes(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              final List<Note> noteList =
                  snapshot.data.documents.map((document) {
                return Note(
                    noteId: document['noteId'],
                    title: document['title'],
                    message: document['message']);
              }).toList();
              if (noteList.isEmpty) return new Text('Nothing Here');
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount(context),
                ),
                shrinkWrap: true,
                itemBuilder: (context, i) => NoteView(noteList[i]),
                itemCount: noteList.length,
              );
          }
        });
  }
}

class NoteView extends StatelessWidget {
  final Note _note;

  NoteView(this._note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          locator<NavigationService>().navigateTo(editNote, argument: _note),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _note.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              //Todo: Improve this
              _note.message,
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 7,
            ),
          ],
        ),
      ),
    );
  }
}
