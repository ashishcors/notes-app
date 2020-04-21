import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/services/prefs_service.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  set darkMode(bool isDarkMode) {
    locator<PrefsService>().userPreferences =
        locator<PrefsService>().userPreferences
          ..darkModeEnabled = isDarkMode;
    _darkMode = isDarkMode;
    notifyListeners();
  }
}
