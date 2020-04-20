import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/services/local_storage_service.dart';

class ThemeBloc extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  set darkMode(bool isDarkMode) {
    locator<LocalStorageService>().darkMode = isDarkMode;
    _darkMode = isDarkMode;
    notifyListeners();
  }
}
