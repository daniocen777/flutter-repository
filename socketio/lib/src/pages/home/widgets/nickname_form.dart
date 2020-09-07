import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socketio/src/utils/consts.dart';
import 'package:socketio/src/utils/socket_client.dart';

class NicknameForm extends StatefulWidget {
  const NicknameForm({Key key}) : super(key: key);

  @override
  _NicknameFormState createState() => _NicknameFormState();
}

class _NicknameFormState extends State<NicknameForm> {
  String _nickname = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("What's your nickname?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            SizedBox(height: 20.0),
            CupertinoTextField(
              onChanged: (text) => this._nickname = text,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w300, color: Colors.white),
              placeholder: 'Insert your nickname',
              decoration: BoxDecoration(
                  color: Color(0xff455a64),
                  borderRadius: BorderRadius.circular(5.0)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            CupertinoButton(
              color: ACCENT_COLOR,
              borderRadius: BorderRadius.circular(30.0),
              child: Text('Join to chat',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
              onPressed: () {
                if (_nickname.trim().length > 0) {
                  /* Método para llamar al socket client para unirse al chat */
                  SocketClient.instance.joinToChat(this._nickname);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
