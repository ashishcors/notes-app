import 'package:flutter/foundation.dart';
import 'package:notesapp/src/models/user_preferences.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'emailId': emailId,
      'userPreferences': userPreferences.toMap()
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        displayName = json['displayName'],
        emailId = json['emailId'],
        userPreferences = UserPreferences.fromJson(json['userPreferences']);
}
