import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Auth._internal();

  static Auth get intance => Auth._internal();

  Future<void> google() async {
    try {
      // Datos de la cuenta
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      // Autenticar la cuenta => token
      final GoogleSignInAuthentication authentication =
          await account.authentication;
      // Credenciales
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      // Obtener datos de ingresar con credenciales => dentro está el usuario
      final AuthResult result =
          await _firebaseAuth.signInWithCredential(credential);
      // Usuario
      final FirebaseUser userFirebase = result.user;

      print(userFirebase.displayName);
    } catch (e) {
      print('ERROR al ingresar => $e');
    }
  }
}
