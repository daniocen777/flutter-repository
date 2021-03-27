import 'package:ydchat/domain/entities/my_chat_entity.dart';
import 'package:ydchat/domain/entities/text_message_entity.dart';
import 'package:ydchat/domain/entities/user_entity.dart';

abstract class FirebaseRepository {

  /* Autenticación */
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();
  Future<void> createCurrentUser(UserEntity userEntity);

  /* Chat, contactos, mensajes */
  Stream<List<UserEntity>>   getAllUsers();
  Stream<List<TextMessageEntity>>   getMessages();
  Stream<List<MyChatEntity>>   getMyChat(String uid);

  Future<void> createOneToOneChatChannel(String uid, String otherUid);
  Future<String> getOneToOneSingleUserChannelId(String uid, String otherUid);
  Future<void> addToMyChat(MyChatEntity myChatEntity);
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity);

}