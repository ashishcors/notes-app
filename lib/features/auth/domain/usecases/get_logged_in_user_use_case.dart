import 'package:notesapp/core/exceptions/api_exception.dart';
import 'package:notesapp/core/usecases/base_usecase.dart';
import 'package:notesapp/core/usecases/safe_result.dart';
import 'package:notesapp/features/auth/domain/entities/user.dart';
import 'package:notesapp/features/auth/domain/repositories/auth_repository.dart';

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
