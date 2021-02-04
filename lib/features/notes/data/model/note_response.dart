import 'package:notesapp/features/notes/domain/entities/note.dart';

class NoteResponse extends Note {
  NoteResponse(String noteId, String title, String message, int color)
      : super(noteId, title, message, color);

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'message': message,
    };
  }

  NoteResponse.fromJson(Map<String, dynamic> json)
      : super(json['noteId'], json['title'], json['message'], json['color']);

  NoteResponse.fromNote(Note note)
      : super(note.noteId, note.title, note.message, note.color);
}
