import 'package:get_it/get_it.dart';
import 'package:notesapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:notesapp/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:notesapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:notesapp/features/auth/domain/usecases/check_email_verified_use_case.dart';
import 'package:notesapp/features/auth/domain/usecases/get_logged_in_user_use_case.dart';
import 'package:notesapp/features/auth/domain/usecases/login_use_case.dart';
import 'package:notesapp/features/auth/domain/usecases/send_verification_email_use_case.dart';
import 'package:notesapp/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:notesapp/features/auth/domain/usecases/signup_use_case.dart';
import 'package:notesapp/features/auth/presentation/login/bloc/login_cubit.dart';
import 'package:notesapp/features/auth/presentation/splash/bloc/splash_cubit.dart';
import 'package:notesapp/src/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());

  // auth
  locator.registerFactory(() => SplashCubit(locator()));
  locator.registerFactory(() => LoginCubit(locator()));

  locator.registerLazySingleton(() => GetLoggedInUserUseCase(locator()));
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => SignupUseCase(locator()));
  locator.registerLazySingleton(() => SignOutUseCase(locator()));
  locator.registerLazySingleton(() => CheckEmailVerifiedUseCase(locator()));
  locator.registerLazySingleton(() => SendVerificationEmailUseCase(locator()));

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
}
