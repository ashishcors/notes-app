import 'package:notesapp/core/usecases/safe_result.dart';

abstract class UseCase<Result, Params> {
  Future<SafeResult<Result>> call(Params params);
}
