import 'package:ydchat/domain/entities/my_chat_entity.dart';
import 'package:ydchat/domain/repositories/firebase_repository.dart';

class AddToMyChatUseCase {
  final FirebaseRepository? firebaseRepository;

  AddToMyChatUseCase({this.firebaseRepository});

  Future<void> call(MyChatEntity myChatEntity) async {
    return await this.firebaseRepository!.addToMyChat(myChatEntity);
  }
}
