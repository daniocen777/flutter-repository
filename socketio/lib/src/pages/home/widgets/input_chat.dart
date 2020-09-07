import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socketio/src/utils/socket_client.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class InputChat extends StatefulWidget {
  final VoidCallback onSend;

  const InputChat({Key key, @required this.onSend}) : super(key: key);

  @override
  _InputChatState createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Color(0xff37474f),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: CupertinoTextField(
                controller: _controller,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(color: Colors.transparent),
                placeholder: 'Your message here',
                style: GoogleFonts.quicksand(color: Colors.white),
                placeholderStyle:
                    GoogleFonts.quicksand(color: Color(0xff546e7a)),
                onChanged: (text) {
                  SocketClient.instance.onInputChange(text);
                },
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.all(5.0),
              borderRadius: BorderRadius.circular(30.0),
              child: Icon(
                Ionicons.ios_send,
                size: 20.0,
              ),
              onPressed: () {
                final bool send = SocketClient.instance.sendMessage();
                // Limpinado controlador
                if (send) {
                  _controller.text = '';
                  widget.onSend();
                }
              },
            ),
          ],
        ));
  }
}
