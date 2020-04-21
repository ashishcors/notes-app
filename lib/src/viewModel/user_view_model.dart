import 'package:flutter/foundation.dart';
import 'package:notesapp/src/models/user.dart';

class UserViewModel extends ChangeNotifier {
  User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
  }
}
