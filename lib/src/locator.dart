import 'package:get_it/get_it.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DatabaseService());
}
