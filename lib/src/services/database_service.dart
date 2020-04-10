import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/models/user.dart';

class DatabaseService {
  final Firestore _database = Firestore.instance;

  Future<void> addOrUpdateUser(User user) async {
    return _database
        .collection('users')
        .document(user.userId)
        .setData(user.toMap());
  }

  Stream<QuerySnapshot> getNotes(String userId) async* {
    yield* _database
        .collection('users')
        .document(userId)
        .collection('notes')
        .snapshots();
  }

  Future<void> addOrUpdateNote(String userId, Note note) async {
    return _database
        .collection('users')
        .document(userId)
        .collection('notes')
        .document(note.noteId)
        .setData(note.toMap());
  }
}
