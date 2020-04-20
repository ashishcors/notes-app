class User {
  var userId;
  var displayName;
  var emailId;

  User({
    this.userId,
    this.displayName,
    this.emailId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'emailId': emailId,
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        displayName = json['displayName'],
        emailId = json['emailId'];
}
