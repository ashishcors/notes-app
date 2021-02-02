import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/notes/domain/entities/note.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repository.dart';

class UpdateNoteUseCase extends UseCase<void, Note> {
  final NotesRepository _repository;

  UpdateNoteUseCase(this._repository);

  @override
  Future<SafeResult<void>> call(Note params) async {
    try {
      final result = await _repository.updateNote(params);
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}
