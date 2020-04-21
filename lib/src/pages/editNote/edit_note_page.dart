import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/pages/editNote/edit_note_view_model.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatelessWidget {
  final _editNoteViewModel = EditNoteViewModel();
  @override
  Widget build(BuildContext context) {
    final Note _note =
        ModalRoute.of(context).settings.arguments ?? Note.newEmptyNote();
    _editNoteViewModel.setNote(_note);
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<EditNoteViewModel>.value(
          value: _editNoteViewModel,
          child: NotePageLayout(),
        ),
      ),


       /// Using a builder for floatingActionButton because the we need context
       /// from inside scaffold. Same for delete button.
      floatingActionButton: Builder(
        builder: (builderContext) => FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () => _saveNote(builderContext),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () => {},
          ),
          Builder(
            builder: (buildContext) => IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteNote(buildContext),
            ),
          ),
        ],
      ),
    );
  }

  void _saveNote(BuildContext context) {
    showProgress(context, 'Saving note');
    final userId = locator<AuthService>().firebaseUser.uid;

    locator<DatabaseService>()
        .addOrUpdateNote(userId, _editNoteViewModel.note)
        .then((value) => locator<NavigationService>().goBack())
        .catchError((e) => showMessage(context, e.toString()));
  }

  void _deleteNote(BuildContext context) {
    showProgress(context, 'Deleting note');
    final userId = locator<AuthService>().firebaseUser.uid;

    locator<DatabaseService>()
        .deleteNote(userId, _editNoteViewModel.note)
        .then((value) => locator<NavigationService>().goBack())
        .catchError((e) => showMessage(context, e.toString()));
  }
}

class NotePageLayout extends StatefulWidget {
  @override
  _NotePageLayoutState createState() => _NotePageLayoutState();
}

class _NotePageLayoutState extends State<NotePageLayout> {
  FocusNode _focusNode = FocusNode();

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      locator<NavigationService>().goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final editNoteViewModel = Provider.of<EditNoteViewModel>(context);
    FocusScope.of(context).requestFocus(_focusNode);
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            TextField(
              controller:
                  TextEditingController(text: editNoteViewModel.note.title),
              onChanged: (text) => editNoteViewModel.setNoteValue(title: text),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration.collapsed(hintText: 'Title'),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Expanded(
              child: TextField(
                controller:
                    TextEditingController(text: editNoteViewModel.note.message),
                onChanged: (text) =>
                    editNoteViewModel.setNoteValue(message: text),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration.collapsed(hintText: 'Message'),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
