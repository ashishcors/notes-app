import 'package:notesapp/features/notes/data/sources/notes_data_source.dart';
import 'package:notesapp/features/notes/domain/entities/note.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repository.dart';

class NotesRepositoryImpl extends NotesRepository {
  final NotesDataSource _dataSource;

  NotesRepositoryImpl(this._dataSource);

  @override
  Future<void> addNote(Note note) {
    return _dataSource.addNote(note);
  }

  @override
  Future<void> deleteNote(String noteId) {
    return _dataSource.deleteNote(noteId);
  }

  @override
  Stream<List<Note>> getNotesStream() {
    return _dataSource.getNotesStream();
  }

  @override
  Future<void> updateNote(Note note) {
    return _dataSource.updateNote(note);
  }
}
