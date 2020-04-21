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

Note welcomeNote() {
  return Note(
      noteId: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Welome to Notes App',
      message: 'This is app is made using flutter. '
          'The source code for this project can be found at '
          'https://github.com/AshishSumanCSE/notes-app');
}
