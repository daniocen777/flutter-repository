import 'package:ydchat/domain/repositories/firebase_repository.dart';

class GetCurrentUidUserCase {
  final FirebaseRepository? firebaseRepository;

  GetCurrentUidUserCase({this.firebaseRepository});

  Future<String> call() async {
    return await this.firebaseRepository!.getCurrentUid();
  }
}
