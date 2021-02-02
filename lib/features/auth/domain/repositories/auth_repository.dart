import 'package:notesapp/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);

  Future<void> signup(String name, String email, String password);

  Future<bool> checkEmailVerified();

  Future<void> sendVerificationEmail();

  Future<void> signOut();

  Future<User> getLoggedInUser();
}
