import 'package:ydchat/domain/repositories/firebase_repository.dart';

class IsSignInUserCase {
  final FirebaseRepository? firebaseRepository;

  IsSignInUserCase({this.firebaseRepository});

  Future<bool> call() async {
    return await this.firebaseRepository!.isSignIn();
  }
}
