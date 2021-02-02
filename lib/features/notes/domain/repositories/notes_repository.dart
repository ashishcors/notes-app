import 'package:notesapp/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  Stream<List<Note>> getNotesStream();

  Future<void> addNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(String noteId);
}
