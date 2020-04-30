import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/prefs_service.dart';

import '../locator.dart';

class AuthRepository {
  PrefsService _prefsService;
  DatabaseService _databaseService;
  AuthService _authService;

  NotesRepository() {
    init();
  }

  void init() async {
    _authService = locator<AuthService>();
    _databaseService = locator<DatabaseService>();
    _prefsService = locator<PrefsService>();
  }
}
