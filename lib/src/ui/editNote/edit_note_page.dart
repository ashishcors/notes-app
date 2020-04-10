import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/models/note.dart';

class EditNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Note _note = ModalRoute.of(context).settings.arguments ??
        Note(noteId: DateTime.now().millisecondsSinceEpoch);
    return Scaffold(
      body: SafeArea(child: NotePageLayout(_note)),
    );
  }
}

class NotePageLayout extends StatefulWidget {
  final Note _note;

  NotePageLayout(this._note);

  @override
  _NotePageLayoutState createState() => _NotePageLayoutState(_note);
}

class _NotePageLayoutState extends State<NotePageLayout> {
  final Note _note;

  _NotePageLayoutState(this._note);

  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = _note.title;
    _messageController.text = _note.message;
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
            controller: _titleController,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration.collapsed(hintText: 'Message'),
            controller: _messageController,
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
