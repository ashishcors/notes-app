import 'package:notesapp/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:notesapp/features/auth/domain/entities/user.dart';
import 'package:notesapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> checkEmailVerified() {
    return _remoteDataSource.checkEmailVerified();
  }

  @override
  Future<void> login(String email, String password) {
    return _remoteDataSource.login(email, password);
  }

  @override
  Future<void> sendVerificationEmail() {
    return _remoteDataSource.sendVerificationEmail();
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  @override
  Future<void> signup(String name, String email, String password) {
    return _remoteDataSource.signup(name, email, password);
  }

  @override
  Future<User> getLoggedInUser() {
    return _remoteDataSource.getLoggedInUser();
  }
}
