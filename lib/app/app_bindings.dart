import 'package:get/get.dart';

import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/data/sources/auth_remote_data_source.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/get_logged_in_user_use_case.dart';
import '../features/auth/domain/usecases/sign_out_use_case.dart';
import '../features/notes/data/repositories/notes_repository_impl.dart';
import '../features/notes/data/sources/notes_data_source.dart';
import '../features/notes/domain/repositories/notes_repository.dart';

/// Define app level dependencies here.
/// Don't put controllers here. They can go into respective bindings for
/// each page, like [HomeBinding].
///
/// Ref: https://github.com/jonataslaw/getx/blob/master/documentation/en_US/dependency_management.md
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // auth
    Get.lazyPut<GetLoggedInUserUseCase>(
        () => GetLoggedInUserUseCase(Get.find()));
    Get.lazyPut<SignOutUseCase>(() => SignOutUseCase(Get.find(), Get.find()));

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());

    // notes
    Get.lazyPut<NotesRepository>(() => NotesRepositoryImpl(Get.find()));
    Get.lazyPut<NotesDataSource>(() => NotesDataSourceImpl());
  }
}
