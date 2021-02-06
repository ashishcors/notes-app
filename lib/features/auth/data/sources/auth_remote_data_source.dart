import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);

  Future<User> signup(String name, String email, String password);

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
  Future<User> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print(result.user.uid + "<<<this");
    return User(
      userId: result.user.uid,
      displayName: result.user.displayName,
      emailId: result.user.email,
    );
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
  Future<User> signup(String name, String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await result.user.updateProfile(displayName: name);
    return User(
      userId: result.user.uid,
      displayName: result.user.displayName,
      emailId: result.user.email,
    );
  }

  @override
  Future<User> getLoggedInUser() async {
    if (_auth.currentUser == null) return null;
    await _auth.currentUser.reload();
    final currentUser = _auth.currentUser;
    return User(
        userId: currentUser.uid,
        displayName: currentUser.displayName,
        emailId: currentUser.email);
  }
}
