import 'package:ydchat/domain/repositories/firebase_repository.dart';

class CreateOneToOneChatChannelUseCase {
  final FirebaseRepository? firebaseRepository;

  CreateOneToOneChatChannelUseCase({this.firebaseRepository});

  Future<void> call(String uid, String otherUid) async {
    return await this
        .firebaseRepository!
        .createOneToOneChatChannel(uid, otherUid);
  }
}
