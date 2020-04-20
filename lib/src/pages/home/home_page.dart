import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/bloc/theme_bloc.dart';
import 'package:notesapp/src/bloc/user_bloc.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/models/user.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/widgets/drawer_layout.dart';
import 'package:provider/provider.dart';

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
      locator<NavigationService>().navigateToClearStack(emailVerificationRoute);
  }

  void _fetchUserData(BuildContext context) async {
    Provider.of<UserBloc>(context, listen: false).user =
        locator<LocalStorageService>().userData;
    final userId = locator<AuthService>().firebaseUser.uid;
    locator<DatabaseService>().getUser(userId).then((value) {
      locator<LocalStorageService>().userData = User.fromJson(value.data);
      Provider.of<UserBloc>(context, listen: false).user =
          locator<LocalStorageService>().userData;
      Provider.of<ThemeBloc>(context, listen: false).darkMode =
          locator<LocalStorageService>().userPreferences.darkModeEnabled;
    }).catchError((_) => {});
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserData(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => locator<NavigationService>().navigateTo(addNoteRoute),
      ),
      body: SafeArea(child: HomePageLayout()),
      appBar: AppBar(
        elevation: 0,
        title: Consumer<UserBloc>(
          builder: (_, userBloc, child) => Text(
            '${userBloc.user?.displayName ?? 'Nameless Fellow'}\'s Notes',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _fetchUserData(context),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      drawer: Drawer(
        child: DrawerLayout(),
      ),
    );
  }
}

class HomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: NoteList(),
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
              return Center(child: new Text('Loading...'));
            default:
              final List<Note> noteList =
                  snapshot.data.documents.map((document) {
                return Note.fromJson(document.data);
              }).toList();
              if (noteList.isEmpty)
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_dissatisfied,
                        size: 40,
                      ),
                      Text(
                        'Nothing Here',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                );
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
      onTap: () => locator<NavigationService>()
          .navigateTo(editNoteRoute, argument: _note),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).backgroundColor,
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
