import 'package:flutter/material.dart';

/* import 'package:cloud_firestore/cloud_firestore.dart'; */
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ydanielchat/widgets/appbar_widget.dart';
import 'package:ydanielchat/widgets/messages.dart';
import 'package:ydanielchat/widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* CollectionReference chats = FirebaseFirestore.instance
        .collection('chats/U4SABRj0spjFI7C7nVxG/messages'); */
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            MyAppBar(
              leftIcon: 'assets/images/camera.svg',
              rightIcon: 'assets/images/logout.svg',
              onRightClick: () {
                print('CLIC DERECHO');
                FirebaseAuth.instance.signOut();
              },
              onLeftClick: () {
                print('CLIC IZQUIERDO');
              },
            ),
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
    ));
  }
}
