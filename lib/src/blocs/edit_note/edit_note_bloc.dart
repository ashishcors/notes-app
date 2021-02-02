import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repository.dart';
import 'package:notesapp/src/blocs/edit_note/edit_note_event.dart';
import 'package:notesapp/src/blocs/edit_note/edit_note_state.dart';
import 'package:notesapp/src/models/note.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  final NotesRepository repository;
  final Note note;

  EditNoteBloc(this.note, this.repository) : super(null);

  EditNoteState get initialState => EditNoteInitial();

  @override
  Stream<EditNoteState> mapEventToState(
    EditNoteEvent event,
  ) async* {
    // if (event is AddOrUpdateNote) {
    //   yield EditNoteProcessing();
    //   try {
    //     await repository.addOrUpdateNote(note);
    //     yield NoteSaved();
    //   } catch (e) {
    //     yield NoteEditingError(e.toString());
    //   }
    // } else if (event is DeleteNote) {
    //   yield EditNoteProcessing();
    //   try {
    //     await repository.deleteNote(note);
    //     yield NoteDeleted();
    //   } catch (e) {
    //     yield NoteEditingError(e.toString());
    //   }
    // }
  }

  TextEditingController titleController;
  TextEditingController messageController;

  void initTextEditingControllers() {
    titleController = TextEditingController(text: note.title);
    messageController = TextEditingController(text: note.message);
  }
}
