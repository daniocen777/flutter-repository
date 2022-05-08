abstract class AuthenticationRepository {
  Future<bool> get isLogued;

  Future<bool> signInWithUserAndPassword(String user, String password);
}
