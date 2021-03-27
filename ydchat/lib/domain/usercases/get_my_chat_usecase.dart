import 'package:ydchat/domain/entities/my_chat_entity.dart';
import 'package:ydchat/domain/repositories/firebase_repository.dart';

class GetMyChatUseCase {
  final FirebaseRepository? firebaseRepository;

  GetMyChatUseCase({this.firebaseRepository});

  Stream<List<MyChatEntity>> call(String uid) {
    return this.firebaseRepository!.getMyChat(uid);
  }
}
