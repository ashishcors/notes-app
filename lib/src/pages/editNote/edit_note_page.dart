import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/src/blocs/edit_note/edit_note_bloc.dart';
import 'package:notesapp/src/blocs/edit_note/edit_note_event.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/repositories/notes_repository.dart';
import 'package:notesapp/src/services/navigation_service.dart';

class EditNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _editNoteBloc = EditNoteBloc(
        ModalRoute.of(context).settings.arguments ?? Note.newEmptyNote(),
        NotesRepository());
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<EditNoteBloc>.value(
          value: _editNoteBloc,
          child: NotePageLayout(),
        ),
      ),

      /// Using a builder for floatingActionButton because the we need context
      /// from inside scaffold. Same for delete button.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () => _editNoteBloc.add(AddOrUpdateNote()),
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
              onPressed: () => _editNoteBloc.add(DeleteNote()),
            ),
          ),
        ],
      ),
    );
  }
}

class NotePageLayout extends StatelessWidget {
  final _focusNode = FocusNode();

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      locator<NavigationService>().goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EditNoteBloc>(context).initTextEditingControllers();
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
                  BlocProvider.of<EditNoteBloc>(context).titleController,
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
                    BlocProvider.of<EditNoteBloc>(context).messageController,
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
