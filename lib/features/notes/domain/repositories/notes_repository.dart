import '../entities/note.dart';

abstract class NotesRepository {
  Stream<List<Note>> getNotesStream(String userId);

  Future<void> addNote(Note note, String userId);

  Future<void> updateNote(Note note, String userId);

  Future<void> deleteNote(String noteId, String userId);
}
