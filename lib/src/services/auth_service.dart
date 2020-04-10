import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  FirebaseUser _firebaseUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> loginUser(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = result.user;
    _isUserLoggedIn = true;
    return _firebaseUser;
  }

  Future<FirebaseUser> registerUser(
      String name, String email, String password) async {
    var result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = result.user;
    _isUserLoggedIn = true;
    return _firebaseUser;
  }
}
