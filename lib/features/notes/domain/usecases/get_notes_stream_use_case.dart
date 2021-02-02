import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/notes/domain/entities/note.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repository.dart';

class GetNotesSteamNoteUseCase extends UseCase<Stream<List<Note>>, void> {
  final NotesRepository _repository;

  GetNotesSteamNoteUseCase(this._repository);

  @override
  Future<SafeResult<Stream<List<Note>>>> call(void params) async {
    try {
      return Success(_repository.getNotesStream());
    } catch (e) {
      return Failure(e);
    }
  }
}
