import '../../../../core/services/prefs_service.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../repositories/notes_repository.dart';

class DeleteNoteUseCase extends UseCase<void, String> {
  final NotesRepository _repository;
  final PrefsService _prefsService;

  DeleteNoteUseCase(this._repository, this._prefsService);

  @override
  Future<SafeResult<void>> call(String params) async {
    try {
      final result = await _repository.deleteNote(params, _prefsService.userId);
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}
