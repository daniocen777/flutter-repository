import 'package:ydchat/domain/repositories/firebase_repository.dart';

class VerifyPhoneNumberUserCase {
  final FirebaseRepository? firebaseRepository;

  VerifyPhoneNumberUserCase({this.firebaseRepository});

  Future<void> call(String phoneNumber) async {
    return await this.firebaseRepository!.verifyPhoneNumber(phoneNumber);
  }
}
