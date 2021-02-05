import '../../../../core/services/prefs_service.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class UpdateNoteUseCase extends UseCase<void, Note> {
  final NotesRepository _repository;
  final PrefsService _prefsService;

  UpdateNoteUseCase(this._repository, this._prefsService);

  @override
  Future<SafeResult<void>> call(Note params) async {
    try {
      final result = await _repository.updateNote(params, _prefsService.userId);
      return Success(result);
    } catch (e) {
      print(e);
      return Failure(e);
    }
  }
}
