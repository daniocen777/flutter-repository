import '../../data/models/user.dart';
import '../providers/authentication_provider.dart';
import '../../data/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider;

  /* Para la inyección de dependencias */
  AuthenticationRepositoryImpl(this._authenticationProvider);

  @override
  Future<User?> login(String email, String password) {
    return _authenticationProvider.login(email, password);
  }

  @override
  Future<bool?> register(User user) async {
    return null;
  }

  @override
  Future<bool?> sendResetToken(String email) async {
    return null;
  }
}
