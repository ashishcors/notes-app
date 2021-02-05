import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../repositories/auth_repository.dart';

class SendVerificationEmailUseCase extends UseCase<void, void> {
  final AuthRepository _repository;

  SendVerificationEmailUseCase(this._repository);

  @override
  Future<SafeResult<void>> call(params) async {
    try {
      final result = await _repository.sendVerificationEmail();
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}
