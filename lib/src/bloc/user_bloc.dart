import 'package:flutter/foundation.dart';
import 'package:notesapp/src/models/user.dart';

class UserBloc extends ChangeNotifier {
  User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }
}
