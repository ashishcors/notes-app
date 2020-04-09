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
      'userid': userId,
      'displayName': displayName,
      'emailid': emailId,
    };
  }
}
