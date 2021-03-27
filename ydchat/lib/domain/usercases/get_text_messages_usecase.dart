import 'package:ydchat/domain/entities/text_message_entity.dart'; 
import 'package:ydchat/domain/repositories/firebase_repository.dart';

class GetTextMessagesUseCase {
  final FirebaseRepository? firebaseRepository;

  GetTextMessagesUseCase({this.firebaseRepository});

  Stream<List<TextMessageEntity>> call() {
    return this.firebaseRepository!.getMessages();
  }
}
