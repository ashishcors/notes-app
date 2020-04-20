import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/models/user.dart';

class DatabaseService {
  final Firestore _database = Firestore.instance;

  static const _USERS = 'users';
  static const _NOTES = 'notes';

  Future<void> addOrUpdateUser(User user) async {
    return _database
        .collection(_USERS)
        .document(user.userId)
        .setData(user.toMap());
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return _database.collection(_USERS).document(userId).get();
  }

  Stream<QuerySnapshot> getNotes(String userId) async* {
    yield* _database
        .collection(_USERS)
        .document(userId)
        .collection(_NOTES)
        .snapshots();
  }

  Future<void> addOrUpdateNote(String userId, Note note) async {
    return _database
        .collection(_USERS)
        .document(userId)
        .collection(_NOTES)
        .document(note.noteId)
        .setData(note.toMap());
  }

  Future<void> deleteNote(String userId, Note note) async {
    return _database
        .collection(_USERS)
        .document(userId)
        .collection(_NOTES)
        .document(note.noteId)
        .delete();
  }
}
