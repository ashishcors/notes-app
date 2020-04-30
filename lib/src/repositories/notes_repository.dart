import 'dart:async';

import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/prefs_service.dart';

class NotesRepository {
  PrefsService _prefsService;
  DatabaseService _databaseService;

  NotesRepository() {
    init();
  }

  void init() async {
    _databaseService = locator<DatabaseService>();
    _prefsService = locator<PrefsService>();
  }

  Stream<List<Note>> fetchNotes() async* {
    yield* _databaseService.getNotes(_prefsService.userData.userId).map(
        (event) => event.documents.map((e) =>
            Note.fromJson(e.data)).toList());
  }
}
