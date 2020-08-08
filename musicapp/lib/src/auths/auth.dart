import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musicapp/src/pages/login/login_page.dart';
import 'package:musicapp/src/utils/dialogs.dart';

class Auth {
  /* Patrón singleton */
  Auth._internal();
  static Auth get instance => Auth._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> google(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(credential)).user;
      progressDialog.dismiss();
      /* print("ENTRANDO... " + user.displayName); */
      return user;
    } catch (e) {
      print('ERROR => $e');
      progressDialog.dismiss();
      return null;
    }
  }

  Future<FirebaseUser> signUp(BuildContext context,
      {@required String username,
      @required String email,
      @required String password}) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final AuthResult result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        /* Se crea correctamente el usuario */
        final UserUpdateInfo userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = username;
        await result.user.updateProfile(userUpdateInfo);
        return result.user;
      }
      progressDialog.dismiss();
      return null;
    } on PlatformException catch (e) {
      String message = 'Unknown';
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        message = e.message;
      } else if (e.code == 'ERROR_WEAK_PASSWORD') {
        message = e.message;
      }
      print('ERROR => $e');
      progressDialog.dismiss();
      Dialogs.alert(context, title: 'ERROR', description: message);
      return null;
    }
  }

  Future<FirebaseUser> get user async {
    return await _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> loginByPassword(BuildContext context,
      {@required String email, @required String password}) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      progressDialog.dismiss();
      if (result.user != null) {
        return result.user;
      }
      return null;
    } on PlatformException catch (e) {
      String message = 'Unknown';
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        message = e.message;
      } else {
        message = e.message;
      }
      progressDialog.dismiss();
      Dialogs.alert(context, title: 'ERROR', description: message);
      return null;
    }
  }

  /* Reiniciar contraseña */
  Future<bool> sendResetEmailLink(BuildContext context,
      {@required String email}) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      progressDialog.dismiss();
      return true;
    } on PlatformException catch (e) {
      progressDialog.dismiss();
      Dialogs.alert(context, title: 'ERROR', description: e.message);
      return false;
    }
  }

  Future<void> logOut(BuildContext context) async {
    final List<UserInfo> providers = (await user).providerData;
    String providerId = 'firebase';
    for (final p in providers) {
      if (p.providerId != 'firebase') {
        providerId = p.providerId;
        break;
      }
    }

    print('PROVIDER ID => $providerId');

    switch (providerId) {
      case 'facebook.com':
        break;
      case 'google.com':
        await _googleSignIn.signOut();
        break;
      case 'password':
        break;
      case 'phone':
        break;
      default:
    }
    await _firebaseAuth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (_) => false);
  }
}
