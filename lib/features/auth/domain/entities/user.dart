import 'package:flutter/foundation.dart';

import 'user_preference.dart';

class User {
  String userId;
  String displayName;
  String emailId;
  UserPreferences userPreferences;

  User({
    @required this.userId,
    @required this.displayName,
    @required this.emailId,
    this.userPreferences = null,
  });
}
