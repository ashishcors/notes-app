import '../../../../core/services/prefs_service.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<void, LoginParams> {
  final AuthRepository _repository;
  final PrefsService _prefsService;

  LoginUseCase(this._repository, this._prefsService);

  @override
  Future<SafeResult<void>> call(params) async {
    try {
      final result = await _repository.login(params.email, params.password);
      _prefsService.userId = result.userId;
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
