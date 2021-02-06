import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> checkEmailVerified() {
    return _remoteDataSource.checkEmailVerified();
  }

  @override
  Future<User> login(String email, String password) {
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
  Future<User> signup(String name, String email, String password) {
    return _remoteDataSource.signup(name, email, password);
  }

  @override
  Future<User> getLoggedInUser() {
    return _remoteDataSource.getLoggedInUser();
  }
}
