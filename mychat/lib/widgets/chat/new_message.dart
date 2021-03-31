import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/colors.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String? _enteredMessage = '';
  CollectionReference _chat = FirebaseFirestore.instance.collection('chat');

  void _sendMessage() async {
    /* FocusScope.of(context).unfocus(); */
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    _chat.add({
      'text': this._enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username']
    });
    this._enteredMessage = '';
    this._controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: this._controller,
              decoration: InputDecoration(
                labelText: 'Escribe el mensaje...',
              ),
              onChanged: (value) {
                setState(() {
                  this._enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send,
                  color: (this._enteredMessage?.trim().length == 0)
                      ? Colors.grey
                      : secondColor),
              onPressed: this._enteredMessage?.trim().length == 0
                  ? null
                  : this._sendMessage)
        ],
      ),
    );
  }
}
