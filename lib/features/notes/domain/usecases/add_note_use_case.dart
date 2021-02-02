import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/notes/domain/entities/note.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repository.dart';

class AddNoteUseCase extends UseCase<void, AddNoteParam> {
  final NotesRepository _repository;

  AddNoteUseCase(this._repository);

  @override
  Future<SafeResult<void>> call(AddNoteParam params) async {
    final noteId = DateTime.now().microsecondsSinceEpoch.toString();
    final note = Note(noteId, params.title, params.message, params.color);
    try {
      final result = await _repository.addNote(note);
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}

class AddNoteParam {
  final String title;
  final String message;
  final int color;

  AddNoteParam(this.title, this.message, this.color);
}
