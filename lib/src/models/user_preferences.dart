class UserPreferences {
  bool darkModeEnabled = false;

  UserPreferences({this.darkModeEnabled = false});

  UserPreferences.fromJson(Map<String, dynamic> json)
      : darkModeEnabled = json['darkModeEnabled'];

  Map<String, dynamic> toMap() {
    return {
      'darkModeEnabled': darkModeEnabled,
    };
  }
}
