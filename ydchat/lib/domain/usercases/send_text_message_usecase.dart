import 'package:ydchat/domain/entities/text_message_entity.dart';
import 'package:ydchat/domain/repositories/firebase_repository.dart';

class SendTextMessageUseCase {
  final FirebaseRepository? firebaseRepository;

  SendTextMessageUseCase({this.firebaseRepository});

  Future<void> call(TextMessageEntity textMessageEntity) async {
    return await this.firebaseRepository!.sendTextMessage(textMessageEntity);
  }
}
