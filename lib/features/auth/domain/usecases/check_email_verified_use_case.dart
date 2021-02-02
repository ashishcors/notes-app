import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/auth/domain/repositories/auth_repository.dart';

class CheckEmailVerifiedUseCase extends UseCase<bool, void> {
  final AuthRepository _repository;

  CheckEmailVerifiedUseCase(this._repository);

  @override
  Future<SafeResult<bool>> call(params) async {
    try {
      final result = await _repository.checkEmailVerified();
      return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}
