import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:mytelegram/utils/encrypt_decrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widgets/FullImageWidget.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../widgets/ProgressWidget.dart';

class Chat extends StatelessWidget {
  final String? receiverId;
  final String? receiverAvatar;
  final String? receiverName;

  const Chat(
      {Key? key, this.receiverId, this.receiverAvatar, this.receiverName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              backgroundImage: NetworkImage(this.receiverAvatar!),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(this.receiverName!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      body: ChatScreen(
          receiverId: this.receiverId, receiverAvatar: this.receiverAvatar),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String? receiverId;
  final String? receiverAvatar;

  const ChatScreen({Key? key, this.receiverId, this.receiverAvatar})
      : super(key: key);

  @override
  State createState() => ChatScreenState(
      receiverId: this.receiverId, receiverAvatar: this.receiverAvatar);
}

class ChatScreenState extends State<ChatScreen> {
  final String? receiverId;
  final String? receiverAvatar;

  ChatScreenState({Key? key, this.receiverId, this.receiverAvatar});

  final _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _focusNode = FocusNode();
  bool? _isDisplayStick;
  bool? _isLoading;
  final _picker = ImagePicker();
  File? _imageFile;
  String? _imagefeUrl;

  String? _chatId;
  String? _id;
  SharedPreferences? _preferences;

  List<QueryDocumentSnapshot>? _listMessages;

  @override
  void initState() {
    super.initState();
    this._focusNode.addListener(onFocusChange);
    this._isDisplayStick = false;
    this._isLoading = false;
    this._chatId = '';
    this.readLocal();
  }

  void readLocal() async {
    this._preferences = await SharedPreferences.getInstance();
    this._id = this._preferences!.getString('id') ?? '';
    if (this._id.hashCode <= this.receiverId.hashCode) {
      this._chatId = '${this._id}-${this.receiverId}';
    } else {
      this._chatId = '${this.receiverId}-${this._id}';
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(this._id)
        .update({'chattingWith': this.receiverId});
    setState(() {});
  }

  void onFocusChange() {
    if (this._focusNode.hasFocus) {
      /* Esconder stickers si está enfocado el textField para enviar mensaje */
      setState(() {
        this._isDisplayStick = false;
      });
    }
  }

  Widget _createInput() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Row(
        children: [
          /* Enviar imagen */
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                  icon: Icon(CupertinoIcons.photo),
                  color: secondColor,
                  onPressed: getImageFromGallery),
            ),
          ),
          /* Enviar emoji */
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                  icon: Icon(CupertinoIcons.gift),
                  color: secondColor,
                  onPressed: getStickers),
            ),
          ),
          /* Mensaje */
          Flexible(
              child: Container(
            child: TextField(
              controller: this._textEditingController,
              style: TextStyle(color: Colors.black87, fontSize: 15.0),
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              focusNode: this._focusNode,
            ),
          )),
          /* Botón para enviar */
          Material(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                  color: secondColor,
                  icon: Icon(CupertinoIcons.paperplane),
                  onPressed: () =>
                      onSendMessage(this._textEditingController.text, 0)),
            ),
          )
        ],
      ),
    );
  }

  Widget createListMessages() {
    return Flexible(
        child: this._chatId == ''
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(secondColor),
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .doc(this._chatId)
                    .collection(this._chatId!)
                    .orderBy('timestamp', descending: true)
                    .limit(20)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressWidget();
                  }

                  this._listMessages = snapshot.data!.docs;

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    controller: this._scrollController,
                    itemBuilder: (BuildContext context, int index) =>
                        createItem(index, snapshot.data!.docs[index]),
                  );
                },
              ));
  }

  Widget createItem(int index, QueryDocumentSnapshot document) {
    /* Mis mensajes => derecha */
    MyEncripter myEncripter = MyEncripter();
    final String messageDecrypt = myEncripter.decryptAES(document['content']);
    if (document['idFrom'] == this._id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (document['type'] == 0)
              ? Container(
                  width: 200,
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(messageDecrypt,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                )
              : (document['type'] == 1)
                  ? Container(
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                      child: TextButton(
                        child: Material(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: ExtendedImage.network(
                              messageDecrypt,
                              width: 150.0,
                              height: 150.0,
                              cache: true,
                              fit: BoxFit.cover,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                              printError: true,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FullPhoto(url: messageDecrypt)));
                        },
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                      child: Image.asset(
                        'assets/images/$messageDecrypt.gif',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    )
        ],
      );
    } else {
      /* Mensaje que recibo => izquierda */
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              /* Avatar */
              children: [
                this.isLastMessageLeft(index)
                    ? Material(
                        child: Container(
                          padding: EdgeInsets.only(right: 10.0),
                          child: ExtendedImage.network(
                            this.receiverAvatar!,
                            width: 35.0,
                            height: 35.0,
                            cache: true,
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            printError: true,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : Container(
                        width: 35.0,
                      ),
                (document['type'] == 0)
                    ? Container(
                        width: 200,
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        decoration: BoxDecoration(
                            color: thirdColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(messageDecrypt,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                      )
                    : (document['type'] == 1)
                        ? Container(
                            child: TextButton(
                              child: Material(
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: ExtendedImage.network(
                                    messageDecrypt,
                                    width: 150.0,
                                    height: 150.0,
                                    cache: true,
                                    fit: BoxFit.cover,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    clipBehavior: Clip.hardEdge,
                                    printError: true,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            FullPhoto(url: messageDecrypt)));
                              },
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                            child: Image.asset(
                              'assets/images/$messageDecrypt.gif',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          )
              ],
            ),

            /* Fecha */
            this.isLastMessageLeft(index)
                ? Container(
                    margin: EdgeInsets.only(left: 50.0, top: 50.0, bottom: 5.0),
                    child: Text(
                      DateFormat('dd MMMM, yyyy - hh:mm::aa').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document['timestamp']))),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : Container()
          ],
        ),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            this._listMessages != null &&
            this._listMessages![index - 1]['idFrom'] == this._id) ||
        (index == 0)) {
      return true;
    }

    return false;
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            this._listMessages != null &&
            this._listMessages![index - 1]['idFrom'] != this._id) ||
        (index == 0)) {
      return true;
    }

    return false;
  }

  Widget createStickers(Responsive responsive) {
    return Container(
      height: responsive.hp(50.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /* 1 */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => onSendMessage('mimi1', 2),
                  child: Image.asset(
                    'assets/images/mimi1.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )),
              TextButton(
                  onPressed: () => onSendMessage('mimi2', 2),
                  child: Image.asset(
                    'assets/images/mimi2.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )),
              TextButton(
                  onPressed: () => onSendMessage('mimi3', 2),
                  child: Image.asset(
                    'assets/images/mimi3.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ))
            ],
          ),
          /* 2 */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => onSendMessage('mimi4', 2),
                  child: Image.asset(
                    'assets/images/mimi4.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )),
              TextButton(
                  onPressed: () => onSendMessage('mimi5', 2),
                  child: Image.asset(
                    'assets/images/mimi5.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )),
              TextButton(
                  onPressed: () => onSendMessage('mimi6', 2),
                  child: Image.asset(
                    'assets/images/mimi6.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ))
            ],
          ),
          /* 3 */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => onSendMessage('mimi7', 2),
                  child: Image.asset(
                    'assets/images/mimi7.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )),
              TextButton(
                  onPressed: () => onSendMessage('mimi8', 2),
                  child: Image.asset(
                    'assets/images/mimi8.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )),
              TextButton(
                  onPressed: () => onSendMessage('mimi9', 2),
                  child: Image.asset(
                    'assets/images/mimi9.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget createLoading() {
    return Positioned(
        child: (this._isLoading!) ? CircularProgressWidget() : Container());
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      this._imageFile = File(pickedFile.path);
      this._isLoading = true;
    }

    uploadImageFile();
  }

  Future<void> uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('chat images')
        .child(fileName);

    try {
      await storageReference.putFile(this._imageFile!);

      String downloadURL = await storageReference.getDownloadURL();
      this._imagefeUrl = downloadURL;

      setState(() {
        this._isLoading = false;
        onSendMessage(this._imagefeUrl!, 1);
      });
    } on firebase_storage.FirebaseException catch (e) {
      Fluttertoast.showToast(msg: '$e');
      setState(() {
        this._isLoading = false;
      });
    }
  }

  void sendNotify(String title, String body, String id) async {
    String serverToken =
        'AAAAgOBjLTI:APA91bHlK9A8cLbcf0ruWYVaSBb7yOS3AjHRlPYQGOzcCOCFXaUBvjPpTI5QvsAno2-yDyvmQoFLg1jRqQD4gG9Tl378k139omwLrtES0Pv1UeEIgzqN4hwhSilzoNY7jMD2VF-6J3BM';
    String token = this._preferences!.getString('token')!;
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id,
            'status': 'done'
          },
          'to': token,
        },
      ),
    );
  }

  void onSendMessage(String message, int type) {
    /* 0 => Texto
       1 => imagen
       2 => Emoji
     */

    MyEncripter myEncripter = MyEncripter();

    final messageEncrypt = myEncripter.encryptAES(message);
    if (message != "") {
      this._textEditingController.clear();
      DocumentReference messagesReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(this._chatId)
          .collection(this._chatId!)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(messagesReference, {
          'idFrom': this._id,
          'idTo': this.receiverId,
          'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
          'content': messageEncrypt,
          'type': type
        });
      });
      this._scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

      this.sendNotify('Nuevo mensaje', message, this.receiverId!);
    } else {
      Fluttertoast.showToast(msg: 'Tienes que enviar un mensaje');
    }
  }

  void getStickers() {
    _focusNode.unfocus();
    setState(() {
      this._isDisplayStick = !this._isDisplayStick!;
    });
  }

  Future<bool> onBackPress() {
    if (this._isDisplayStick!) {
      setState(() {
        this._isDisplayStick = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return WillPopScope(
        child: Stack(
          children: [
            Column(
              children: [
                /* Mensajes */
                createListMessages(),
                /* Mostrar stocker */
                (this._isDisplayStick!)
                    ? createStickers(responsive)
                    : Container(),
                // Control para los mensajes
                _createInput()
              ],
            ),
            createLoading()
          ],
        ),
        onWillPop: onBackPress);
  }
}
