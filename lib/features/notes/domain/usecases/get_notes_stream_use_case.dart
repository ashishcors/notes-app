import '../../../../core/services/prefs_service.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class GetNotesSteamNoteUseCase extends UseCase<Stream<List<Note>>, void> {
  final NotesRepository _repository;
  final PrefsService _prefsService;

  GetNotesSteamNoteUseCase(this._repository, this._prefsService);

  @override
  Future<SafeResult<Stream<List<Note>>>> call(void params) async {
    try {
      return Success(_repository.getNotesStream(_prefsService.userId));
    } catch (e) {
      return Failure(e);
    }
  }
}
