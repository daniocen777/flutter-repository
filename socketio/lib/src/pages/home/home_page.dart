import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socketio/src/pages/home/widgets/chat.dart';
import 'package:socketio/src/pages/home/widgets/nickname_form.dart';
import 'package:socketio/src/utils/consts.dart';

import 'package:socketio/src/utils/socket_client.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SocketClient.instance.init();
    // Iniciando el socket
    SocketClient.instance.connect();
    super.initState();
  }

  @override
  void dispose() {
    SocketClient.instance.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff102027),
        appBar: AppBar(
          backgroundColor: ACCENT_COLOR,
          title: Obx(() {
            final numUsers = SocketClient.instance.numUsers;
            return Text('Users (${numUsers.value})');
          }),
        ),
        body: Obx(() {
          final status = SocketClient.instance.status;
          if (status.value == SocketStatus.connecting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (status.value == SocketStatus.connected) {
            return NicknameForm();
          } else if (status.value == SocketStatus.joined) {
            return Chat();
          } else if (status.value == SocketStatus.error) {
            return Center(
              child: Text('ERROR CONNECTION'),
            );
          } else {
            return Center(
              child: Text('DISCONNECTED'),
            );
          }
        }));
  }
}
