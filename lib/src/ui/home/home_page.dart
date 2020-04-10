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

  void _signOut(BuildContext context) {
    locator<AuthService>()
        .signOut()
        .then((value) =>
            locator<NavigationService>().navigateToClearStack(loginRoute))
        .catchError((e) => showMessage(context, e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qnote"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: NoteListView(),
    );
  }
}

class NoteListView extends StatelessWidget {
  final noteList = List<Note>();

  NoteListView() {
    noteList
      ..add(Note(title: 'Note1', message: 'Note Message 1'))
      ..add(Note(title: 'Note2', message: 'Note Message 2'))
      ..add(Note(title: 'Note3', message: 'Note Message 3'))
      ..add(Note(title: 'Note4', message: 'Note Message 4'))
      ..add(Note(title: 'Note5', message: 'Note Message 5'))
      ..add(Note(title: 'Note6', message: 'Note Message 6'));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) => NoteView(noteList[i]),
      itemCount: noteList.length,
    );
  }
}

class NoteView extends StatelessWidget {
  final Note _note;

  NoteView(this._note);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: <Widget>[
          Text(_note.title),
          Text(_note.message),
        ],
      ),
    );
  }
}
