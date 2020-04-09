import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  FirebaseUser _firebaseUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> loginUser(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = result.user;
    _isLoggedIn = true;
    return _firebaseUser;
  }

  Future<FirebaseUser> registerUser(
      String name, String email, String password) async {
    var result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = result.user;
    _isLoggedIn = true;
    return _firebaseUser;
  }
}
