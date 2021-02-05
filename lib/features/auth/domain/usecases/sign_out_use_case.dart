import '../../../../core/services/prefs_service.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<void, void> {
  final AuthRepository _repository;
  final PrefsService _prefsService;

  SignOutUseCase(this._repository, this._prefsService);

  @override
  Future<SafeResult<void>> call(params) async {
    try {
      final result = await _repository.signOut();
      await _prefsService.clear();
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}
