import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase extends UseCase<void, SignupParams> {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  @override
  Future<SafeResult<void>> call(params) async {
    try {
      final result =
          await _repository.signup(params.name, params.email, params.password);
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
