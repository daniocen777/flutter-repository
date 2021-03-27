import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ydchat/data/model/my_chat_model.dart';
import 'package:ydchat/data/model/text_message_model.dart';
import 'package:ydchat/data/model/user_model.dart';
import 'package:ydchat/domain/entities/text_message_entity.dart';
import 'package:ydchat/domain/entities/my_chat_entity.dart';
import 'package:ydchat/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ydchat/data/datasource/firebase_remote_datasource.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth? auth;
  final FirebaseFirestore? fireStore;
  String _verificationId = '';

  FirebaseRemoteDataSourceImpl({this.auth, this.fireStore});

  /* 31 */

  @override
  Future<void> createCurrentUser(UserEntity userEtitty) async {
    final userCollection = this.fireStore!.collection('users');
    final uid = await this.getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
              status: userEtitty.status,
              profielUrl: userEtitty.profielUrl,
              isOnline: userEtitty.isOnline,
              uid: uid,
              phoneNumber: userEtitty.phoneNumber,
              email: userEtitty.email,
              name: userEtitty.name)
          .toDocument();
      if (!userDoc.exists) {
        // Si no existe, crear un nuevo usuario
        userCollection.doc(uid).set(newUser);
      } else {
        // Actualizar usuario
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<String> getCurrentUid() async => this.auth!.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => this.auth!.currentUser!.uid != '';

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsPinCode);
    await this.auth!.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async => await this.auth!.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authCredential) {
      print('Teléfono de verificación: token ${authCredential.token}');
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException firebaseAuthException) {
      print(
          'ERRPR Teléfono de verificación: ${firebaseAuthException.message}, ${firebaseAuthException.code}');
    };

    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
      print('Tiempo terminado: $verificationId');
    };

    final PhoneCodeSent phoneCodeSent =
        (String verificationId, int? forceResendingToken) {};

    this.auth!.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        timeout: const Duration(seconds: 10),
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) {
    // TODO: implement addToMyChat
    throw UnimplementedError();
  }

  @override
  Future<void> createOneToOneChatChannel(String uid, String otherUid) async {
    final userCollectionRef = this.fireStore!.collection("users");
    final oneToOneChatChannelRef = this.fireStore!.collection('myChatChannel');

    userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((chatChannelDoc) {
      if (chatChannelDoc.exists) {
        return;
      }
      //if not exists
      final _chatChannelId = oneToOneChatChannelRef.doc().id;
      var channelMap = {
        "channelId": _chatChannelId,
        "channelType": "oneToOneChat",
      };
      oneToOneChatChannelRef.doc(_chatChannelId).set(channelMap);

      //currentUser
      userCollectionRef
          .doc(uid)
          .collection("engagedChatChannel")
          .doc(otherUid)
          .set(channelMap);

      //OtherUser
      userCollectionRef
          .doc(otherUid)
          .collection("engagedChatChannel")
          .doc(uid)
          .set(channelMap);

      return;
    });
    /* throw ('¨*********************** ERROR => createOneToOneChatChannel ***********************'); */
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollectionRef = this.fireStore!.collection("users");
    return userCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docQuerySnapshot) => UserModel.fromSnapshot(docQuerySnapshot))
          .toList();
    });
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final messagesRef = this
        .fireStore!
        .collection("myChatChannel")
        .doc(channelId)
        .collection('messages');

    return messagesRef.orderBy('time').snapshots().map(
          (querySnap) => querySnap.docs
              .map((doc) => TextMessageModel.fromSnapShot(doc))
              .toList(),
        );
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    final myChatRef =
        this.fireStore!.collection('users').doc(uid).collection('myChat');

    return myChatRef.orderBy('time', descending: true).snapshots().map(
          (querySnap) => querySnap.docs
              .map((doc) => MyChatModel.fromSnapShot(doc))
              .toList(),
        );
  }

  @override
  Future<String> getOneToOneSingleUserChannelId(String uid, String otherUid) {
    final userCollectionRef = this.fireStore!.collection('users');
    return userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((engagedChatChannel) {
      if (engagedChatChannel.exists) {
        return engagedChatChannel.data()!['channelId'];
      }
      return Future.value(null);
    });
  }

  @override
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId) async {
    final messageRef = this
        .fireStore!
        .collection('myChatChannel')
        .doc(channelId)
        .collection('messages');

    final messageId = messageRef.doc().id;

    final newMessage = TextMessageModel(
      message: textMessageEntity.message,
      messageId: messageId,
      messageType: textMessageEntity.messsageType,
      recipientName: textMessageEntity.recipientName,
      recipientUID: textMessageEntity.recipientUID,
      sederUID: textMessageEntity.sederUID,
      senderName: textMessageEntity.senderName,
      time: textMessageEntity.time,
    ).toDocument();

    messageRef.doc(messageId).set(newMessage);
  }
}
