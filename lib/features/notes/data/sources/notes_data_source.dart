import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/features/notes/data/model/note_response.dart';
import 'package:notesapp/features/notes/domain/entities/note.dart';

abstract class NotesDataSource {
  Stream<List<NoteResponse>> getNotesStream();

  Future<void> addNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(String noteId);
}

class NotesDataSourceImpl extends NotesDataSource {
  final _database = FirebaseFirestore.instance;
  final String _userId;

  static const _NOTES = "notes";
  static const _USERS = "users";

  NotesDataSourceImpl(this._userId);

  @override
  Future<void> addNote(Note note) {
    return _database
        .collection(_USERS)
        .doc(_userId)
        .collection(_NOTES)
        .doc(note.noteId)
        .set((note as NoteResponse).toMap());
  }

  @override
  Future<void> deleteNote(String noteId) {
    return _database
        .collection(_USERS)
        .doc(_userId)
        .collection(_NOTES)
        .doc(noteId)
        .delete();
  }

  @override
  Stream<List<NoteResponse>> getNotesStream() async* {
    yield* _database
        .collection(_USERS)
        .doc(_userId)
        .collection(_NOTES)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => NoteResponse.fromJson(e.data())).toList());
  }

  @override
  Future<void> updateNote(Note note) {
    return _database
        .collection(_USERS)
        .doc(_userId)
        .collection(_NOTES)
        .doc(note.noteId)
        .set((note as NoteResponse).toMap());
  }
}
