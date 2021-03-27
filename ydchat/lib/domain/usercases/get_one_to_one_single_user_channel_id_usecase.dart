import 'package:ydchat/domain/repositories/firebase_repository.dart';

class GetOneToOneSingleUserChannelIdUseCase {
  final FirebaseRepository? firebaseRepository;

  GetOneToOneSingleUserChannelIdUseCase({this.firebaseRepository});

  Future<String> call(String uid, String otherUid) async {
    return await this
        .firebaseRepository!
        .getOneToOneSingleUserChannelId(uid, otherUid);
  }
}
