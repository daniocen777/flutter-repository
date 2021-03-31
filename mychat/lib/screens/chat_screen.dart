import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';
import '../screens/auth_screen.dart';

class ChatScreen extends StatelessWidget {
  static final String route = 'chat';

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
        appBar: AppBar(
          title: Text('Chat Privado'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacementNamed(context, AuthScreen.route);
                })
          ],
        ),
        body: SafeArea(
          child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: MessagesWidget(),
                  ),
                  NewMessage()
                ],
              )),
        ));
  }
}
