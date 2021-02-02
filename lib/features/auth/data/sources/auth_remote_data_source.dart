import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:notesapp/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<void> login(String email, String password);

  Future<void> signup(String name, String email, String password);

  Future<bool> checkEmailVerified();

  Future<void> sendVerificationEmail();

  Future<User> getLoggedInUser();

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final _auth = firebase.FirebaseAuth.instance;

  @override
  Future<bool> checkEmailVerified() async {
    await _auth.currentUser.reload();
    return _auth.currentUser.emailVerified;
  }

  @override
  Future<void> login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> sendVerificationEmail() {
    return _auth.currentUser.sendEmailVerification();
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  Future<void> signup(String name, String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await result.user.updateProfile(displayName: name);
  }

  @override
  Future<User> getLoggedInUser() async {
    if (_auth.currentUser == null) return null;
    await _auth.currentUser.reload();
    final currentUser = _auth.currentUser;
    return User(
        userId: currentUser.uid,
        displayName: currentUser.email,
        emailId: currentUser.email);
  }
}
