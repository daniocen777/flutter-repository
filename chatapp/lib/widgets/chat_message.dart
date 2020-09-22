import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {Key key,
      @required this.text,
      @required this.uid,
      @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animationController,
        child: SizeTransition(
                  sizeFactor: CurvedAnimation( 
                    parent: this.animationController, 
                    curve: Curves.easeOut

                   ),
                  child: Container(
              child: this.uid == '123' ? _myMessage() : _notMyMessage()),
        ));
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0, left: 50.0, right: 5.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Color(0xff4d9ef6),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text(this.text,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 50.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Color(0xffe4e5e8),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text(this.text,
            style: TextStyle(
              color: Colors.black87,
            )),
      ),
    );
  }
}
