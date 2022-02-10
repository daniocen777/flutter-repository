import 'package:authapp/app/domain/repositories/account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepositoryImpl implements AccountRepository {
  final FirebaseAuth _auth;

  AccountRepositoryImpl(this._auth);

  @override
  Future<User?> updateDisplayName(String value) async {
    try {
      final user = _auth.currentUser;
      // Asegurar que user es != null
      assert(user != null);
      await user!.updateDisplayName(value);
      // Actualizar para ver el cambio
      user.reload();
      return _auth.currentUser;
    } catch (e) {
      return null;
    }
  }
}
