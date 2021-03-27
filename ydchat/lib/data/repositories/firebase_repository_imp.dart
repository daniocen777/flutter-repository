import 'package:ydchat/domain/entities/text_message_entity.dart';
import 'package:ydchat/domain/entities/my_chat_entity.dart';
import 'package:ydchat/domain/entities/user_entity.dart';

import 'package:ydchat/domain/repositories/firebase_repository.dart';
import 'package:ydchat/data/datasource/firebase_remote_datasource.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource? firebaseRemoteDataSource;

  FirebaseRepositoryImpl({this.firebaseRemoteDataSource});

  @override
  Future<void> createCurrentUser(UserEntity userEntity) async =>
      await this.firebaseRemoteDataSource!.createCurrentUser(userEntity);

  @override
  Future<String> getCurrentUid() async =>
      this.firebaseRemoteDataSource!.getCurrentUid();

  @override
  Future<bool> isSignIn() async =>
      await this.firebaseRemoteDataSource!.isSignIn();

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async =>
      await this.firebaseRemoteDataSource!.signInWithPhoneNumber(smsPinCode);

  @override
  Future<void> signOut() async =>
      await this.firebaseRemoteDataSource!.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async =>
      await this.firebaseRemoteDataSource!.verifyPhoneNumber(phoneNumber);

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) {
    // TODO: implement addToMyChat
    throw UnimplementedError();
  }

  @override
  Future<void> createOneToOneChatChannel(String uid, String otherUid) async =>
      this.firebaseRemoteDataSource!.createOneToOneChatChannel(uid, otherUid);

  @override
  Stream<List<UserEntity>> getAllUsers() =>
      this.firebaseRemoteDataSource!.getAllUsers();

  @override
  Stream<List<TextMessageEntity>> getMessages() {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    // TODO: implement getMyChat
    throw UnimplementedError();
  }

  @override
  Future<String> getOneToOneSingleUserChannelId(
          String uid, String otherUid) async =>
      this
          .firebaseRemoteDataSource!
          .getOneToOneSingleUserChannelId(uid, otherUid);

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity) {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }
}
