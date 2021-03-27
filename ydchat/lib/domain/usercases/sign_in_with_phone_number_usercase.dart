import 'package:ydchat/domain/repositories/firebase_repository.dart';

class SignInWithPhoneNumberUserCase {
  final FirebaseRepository? firebaseRepository;

  SignInWithPhoneNumberUserCase({this.firebaseRepository});

  Future<void> call(String smsPinCode) async {
    return await this.firebaseRepository!.signInWithPhoneNumber(smsPinCode);
  }
}
