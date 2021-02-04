import '../../../../core/services/prefs_service.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../../../core/usecases/safe_result.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class AddNoteUseCase extends UseCase<void, AddNoteParam> {
  final NotesRepository _repository;
  final PrefsService _prefsService;

  AddNoteUseCase(this._repository, this._prefsService);

  @override
  Future<SafeResult<void>> call(AddNoteParam params) async {
    final noteId = DateTime.now().microsecondsSinceEpoch.toString();
    final note = Note(noteId, params.title, params.message, params.color);
    try {
      final result = await _repository.addNote(note, _prefsService.userId);
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
