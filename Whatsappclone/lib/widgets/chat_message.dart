import 'package:Whatsappclone/utils/colors.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String uid;
  final String texto;
  final AnimationController animationController;

  const ChatMessage(
      {Key key,
      @required this.uid,
      @required this.texto,
      @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation( parent: animationController,
        curve: Curves.easeOut
        ),
        child: Container(
          child: this.uid == '123' ? _mensajePropio() : _mensaje(),
        ),
      ),
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
            color: PRIMARY_COLOR_DARK,
            borderRadius: BorderRadius.circular(20.0)),
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
            color: THIRD_COLOR_LIGHT,
            borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
