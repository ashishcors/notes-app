import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/note.dart';
import '../model/note_response.dart';

abstract class NotesDataSource {
  Stream<List<NoteResponse>> getNotesStream(String userId);

  Future<void> addNote(Note note, String userId);

  Future<void> updateNote(Note note, String userId);

  Future<void> deleteNote(String noteId, String userId);
}

class NotesDataSourceImpl extends NotesDataSource {
  final _database = FirebaseFirestore.instance;
  static const _NOTES = "notes";
  static const _USERS = "users";

  @override
  Future<void> addNote(Note note, String userId) {
    return updateNote(note, userId);
  }

  @override
  Future<void> deleteNote(String noteId, String userId) {
    return _database
        .collection(_USERS)
        .doc(userId)
        .collection(_NOTES)
        .doc(noteId)
        .delete();
  }

  @override
  Stream<List<NoteResponse>> getNotesStream(String userId) async* {
    yield* _database
        .collection(_USERS)
        .doc(userId)
        .collection(_NOTES)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => NoteResponse.fromJson(e.data())).toList());
  }

  @override
  Future<void> updateNote(Note note, String userId) {
    return _database
        .collection(_USERS)
        .doc(userId)
        .collection(_NOTES)
        .doc(note.noteId)
        .set(NoteResponse.fromNote(note).toMap());
  }
}
