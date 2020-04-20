import 'package:flutter/cupertino.dart';

class Note {
  String noteId;
  String title = "";
  String message = "";

  Note({
    @required this.noteId,
    this.title = "",
    this.message = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'message': message,
    };
  }

  Note.fromJson(Map<String, dynamic> json)
      : noteId = json['noteId'],
        title = json['title'],
        message = json['message'];
}
