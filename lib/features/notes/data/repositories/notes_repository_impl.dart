import 'package:notesapp/features/notes/data/sources/notes_data_source.dart';
import 'package:notesapp/features/notes/domain/entities/note.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repository.dart';

class NotesRepositoryImpl extends NotesRepository {
  final NotesDataSource _dataSource;

  NotesRepositoryImpl(this._dataSource);

  @override
  Future<void> addNote(Note note, String userId) {
    return _dataSource.addNote(note, userId);
  }

  @override
  Future<void> deleteNote(String noteId, String userId) {
    return _dataSource.deleteNote(noteId, userId);
  }

  @override
  Stream<List<Note>> getNotesStream(String userId) {
    return _dataSource.getNotesStream(userId);
  }

  @override
  Future<void> updateNote(Note note, String userId) {
    return _dataSource.updateNote(note, userId);
  }
}
