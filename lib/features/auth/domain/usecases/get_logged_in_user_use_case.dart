import '../../../../core/exceptions/api_exception.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/safe_result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetLoggedInUserUseCase extends UseCase<User, void> {
  final AuthRepository _repository;

  GetLoggedInUserUseCase(this._repository);

  @override
  Future<SafeResult<User>> call(params) async {
    try {
      final result = await _repository.getLoggedInUser();
      if (result == null)
        throw UnAuthorizedException();
      else
        return Success(result);
    } catch (e) {
      return Failure(e);
    }
  }
}
