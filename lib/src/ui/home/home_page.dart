import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
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
  final noteList = List<Note>();

  int _crossAxisCount(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    if (screenSize > 1000) return 5;
    if (screenSize > 800) return 4;
    if (screenSize > 600) return 3;
    return 2;
  }

  void _signOut(BuildContext context) {
    locator<AuthService>()
        .signOut()
        .then((value) =>
            locator<NavigationService>().navigateToClearStack(loginRoute))
        .catchError((e) => showMessage(context, e.toString()));
  }

  HomePageLayout() {
    noteList
      ..add(Note(title: 'Note1', message: 'Note Message 1'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note6', message: 'Note Message 6'));
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
              )
            ],
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(context),
            ),
            shrinkWrap: true,
            itemBuilder: (context, i) => NoteView(noteList[i]),
            itemCount: noteList.length,
          ),
        ],
      ),
    );
  }
}

class NoteView extends StatelessWidget {
  final Note _note;

  NoteView(this._note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => locator<NavigationService>().navigateTo(addNote,
        argument: _note),
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
          children: <Widget>[
            Text(
              _note.title,
              style: TextStyle(fontSize: 20),
            ),
            Text(_note.message),
          ],
        ),
      ),
    );
  }
}
