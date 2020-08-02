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

  Future<FirebaseUser> get user async {
    return await _firebaseAuth.currentUser();
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
