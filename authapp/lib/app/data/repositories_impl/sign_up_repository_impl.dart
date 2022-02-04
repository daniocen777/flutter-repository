import 'package:authapp/app/domain/inputs/sign_up.dart';
import 'package:authapp/app/domain/repositories/sign_up_repository.dart';
import 'package:authapp/app/domain/response/sign_up_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;

  SignUpRepositoryImpl(this._auth);

  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: data.email, password: data.password);
      await userCredential.user!
          .updateDisplayName('${data.name} ${data.lastname}');
      return SignUpResponse(null, userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(parseStringToSignUpError(e.code), null);
    }
  }
}
