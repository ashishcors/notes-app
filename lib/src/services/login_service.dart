import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesapp/src/models/network_result.dart';

class LoginService {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  FirebaseUser _firebaseUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<NetworkResult<FirebaseUser>> loginUser(
      String email, String password) async {
    var result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      result = e;
    }
    if (result is AuthResult) {
      _firebaseUser = result.user;
      _isLoggedIn = true;
      return NetworkResult.success(_firebaseUser);
    } else if (result is Exception) {
      return NetworkResult.error(result);
    } else {
      return NetworkResult.error(Exception('WTF'));
    }
  }
}
