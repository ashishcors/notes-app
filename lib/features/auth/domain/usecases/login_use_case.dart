import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/auth/domain/entities/user.dart';
import 'package:notesapp/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<void, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<SafeResult<void>> call(params) async {
    try {
      final result = await _repository.login(params.email, params.password);
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}
