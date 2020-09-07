import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socketio/src/models/chat_message.dart';
import 'package:socketio/src/utils/consts.dart';

class MessageItem extends StatelessWidget {
  final ChatMessage chatMessage;

  const MessageItem({Key key, @required this.chatMessage}) : super(key: key);

  Widget getUsernameView() {
    return Text(chatMessage.username,
        style: GoogleFonts.quicksand(fontSize: 12.0, color: Color(0xff718792)));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: (chatMessage.sender) ? WrapAlignment.end : WrapAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: chatMessage.sender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            if (!chatMessage.sender) getUsernameView(),
            Container(
              constraints: BoxConstraints(maxWidth: 300.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: (chatMessage.sender) ? ACCENT_COLOR : Color(0xff455a64),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(chatMessage.sender ? 30.0 : 0.0),
                  bottomRight:
                      Radius.circular(!chatMessage.sender ? 30.0 : 0.0),
                ),
              ),
              child: Text(chatMessage.message, style: GoogleFonts.quicksand()),
            ),
            if (chatMessage.sender) getUsernameView(),
            SizedBox(height: 20.0),
          ],
        ),
      ],
    );
  }
}
