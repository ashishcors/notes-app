import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/utils/ui_utils.dart';

class EditNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notePageLayout = NotePageLayout(
      ModalRoute.of(context).settings.arguments ??
          Note(noteId: DateTime.now().millisecondsSinceEpoch.toString()),
    );
    return Scaffold(
      body: SafeArea(child: notePageLayout),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () => notePageLayout.saveNote(),
      ),
    );
  }
}

class NotePageLayout extends StatefulWidget {
  final Note _note;
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final contextList = List<BuildContext>();

  NotePageLayout(this._note);

  @override
  _NotePageLayoutState createState() => _NotePageLayoutState();

  void saveNote() {
    final context = contextList[0]; //Todo: fix this blunder
    showProgress(context, 'Saving note');
    final userId = locator<AuthService>().firebaseUser.uid;
    _note.title = _titleController.text;
    _note.message = _messageController.text;

    locator<DatabaseService>()
        .addOrUpdateNote(userId, _note)
        .then((value) => locator<NavigationService>().goBack())
        .catchError((e) => showMessage(context, e.toString()));
  }
}

class _NotePageLayoutState extends State<NotePageLayout> {
  @override
  Widget build(BuildContext context) {
    widget.contextList.add(context);
    widget._titleController.text = widget._note.title;
    widget._messageController.text = widget._note.message;
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () => {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => {},
              )
            ],
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration.collapsed(hintText: 'Title'),
            controller: widget._titleController,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration.collapsed(hintText: 'Message'),
            controller: widget._messageController,
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
