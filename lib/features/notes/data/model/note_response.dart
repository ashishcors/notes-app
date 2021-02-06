import '../../domain/entities/note.dart';

class NoteResponse extends Note {
  NoteResponse(
      String noteId, String title, String message, int color, bool isPinned)
      : super(noteId, title, message, color, isPinned);

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'message': message,
      'color': color,
      'isPinned': isPinned,
    };
  }

  NoteResponse.fromJson(Map<String, dynamic> json)
      : super(
          json['noteId'],
          json['title'],
          json['message'],
          json['color'],
          json['isPinned'],
        );

  NoteResponse.fromNote(Note note)
      : super(
          note.noteId,
          note.title,
          note.message,
          note.color,
          note.isPinned,
        );
}
