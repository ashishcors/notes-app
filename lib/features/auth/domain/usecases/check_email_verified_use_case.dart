import '../../../../core/services/prefs_service.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../repositories/auth_repository.dart';

class CheckEmailVerifiedUseCase extends UseCase<bool, void> {
  final AuthRepository _repository;
  final PrefsService _prefsService;

  CheckEmailVerifiedUseCase(this._repository, this._prefsService);

  @override
  Future<SafeResult<bool>> call(params) async {
    if (_prefsService.isEmailVerified) return Success(true);
    try {
      final result = await _repository.checkEmailVerified();
      _prefsService.isEmailVerified = result;
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}
