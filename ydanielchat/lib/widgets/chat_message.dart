import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:ydanielchat/utils/colors.dart';

class ChatMessage extends StatelessWidget {
  final String uid;
  final String texto;

  const ChatMessage({
    Key key,
    @required this.uid,
    @required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.uid != FirebaseAuth.instance.currentUser.uid
          ? _mensajePropio()
          : _mensaje(),
    );
  }

  Widget _mensajePropio() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5.0, left: 50.0, right: 5.0),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: primaryDarkColor, borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget _mensaje() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5.0, right: 50.0, left: 5.0),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
            color: accentLightColor, borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
