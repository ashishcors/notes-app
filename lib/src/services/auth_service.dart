import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  FirebaseUser get firebaseUser => _firebaseUser;

//  bool get isUserLoggedIn => ;

  Future<bool> isUserLoggedIn() async {
    _firebaseUser ??= await _auth.currentUser();
    return _firebaseUser != null;
  }

  Future<bool> isEmailVerified() async {
    _firebaseUser ??= await _auth.currentUser();
    return true;
//    return _firebaseUser != null && _firebaseUser.isEmailVerified;
  }

  Future<FirebaseUser> loginUser(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = result.user;
    return _firebaseUser;
  }

  Future<void> sendVerificationEmail() async {
    var result = await _firebaseUser.sendEmailVerification();
    return result;
  }

  Future<FirebaseUser> registerUser(
      String name, String email, String password) async {
    var result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = result.user;
    return _firebaseUser;
  }

  Future<void> signOut(){
    return _auth.signOut();
  }
}
