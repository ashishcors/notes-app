import 'package:notesapp/core/services/prefs_service.dart';
import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:notesapp/features/notes/domain/usecases/add_note_use_case.dart';

class SignupUseCase extends UseCase<void, SignupParams> {
  final AuthRepository _repository;
  final AddNoteUseCase _addNoteUseCase;
  final PrefsService _prefsService;

  SignupUseCase(this._repository, this._prefsService, this._addNoteUseCase);

  @override
  Future<SafeResult<void>> call(params) async {
    try {
      final result =
          await _repository.signup(params.name, params.email, params.password);
      _prefsService.userId = result.userId;
      await _addNoteUseCase(
          AddNoteParam("Welcome", "Welcome to notesApp.", null));
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}

class SignupParams {
  final String name;
  final String email;
  final String password;

  SignupParams(this.name, this.email, this.password);
}
