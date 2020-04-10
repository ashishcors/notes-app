class Note {
  String noteId;
  String title = "";
  String message = "";

  Note({
    this.noteId,
    this.title,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'message': message,
    };
  }
}
