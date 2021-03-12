import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chat')
        .add({'text': _enteredMessage, 'createdAt': Timestamp.now()});
    _enteredMessage = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _controller,
                decoration:
                    InputDecoration.collapsed(hintText: 'Escribe el mensaje'),
                onChanged: (String value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            // Botón enviar
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _enteredMessage.trim().length == 0
                        ? null
                        : _sendMessage)),
          ],
        ),
      ),
    );
  }
}
