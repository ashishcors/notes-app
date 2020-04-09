import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/src/models/user.dart';

class DatabaseService {
  final Firestore _database = Firestore.instance;

  Future<void> addOrUpdateUser(User user) async {
    return _database
        .collection('users')
        .document(user.userId)
        .setData(user.toMap());
  }
}
