import 'package:ydchat/domain/repositories/firebase_repository.dart';

class SignOutUserCase {
  final FirebaseRepository? firebaseRepository;

  SignOutUserCase({this.firebaseRepository});

  Future<void> call() async {
    return await this.firebaseRepository!.signOut();
  }
}
