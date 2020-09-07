import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socketio/src/models/chat_message.dart';
import 'package:socketio/src/pages/home/widgets/input_chat.dart';
import 'package:socketio/src/pages/home/widgets/message_item.dart';
import 'package:socketio/src/utils/socket_client.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ScrollController _scrollController = ScrollController();
  bool _isEnd = false;
  StreamSubscription _subscription;
  ValueNotifier<int> _counterNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    this._subscription = SocketClient.instance.messages.listen((messages) {
      // Si estamos al final de la lista, hacer scroll
      if (messages.length > 0 && !messages.last.sender) {
        if (_isEnd) {
          this._goToEnd();
        } else if (_scrollController.position.maxScrollExtent > 0) {
          // Mensaje no leído
          _counterNotifier.value += 1;
        }
      }
    });
  }

  @override
  void dispose() {
    this._subscription?.cancel();
    super.dispose();
  }

  void _goToEnd() {
    Future.delayed(Duration(milliseconds: 200), () {
      final double offset = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(offset,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
      _counterNotifier.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Obx(() {
                        final messages = SocketClient.instance.messages;
                        return NotificationListener(
                          child: ListView.builder(
                              controller: _scrollController,
                              physics: BouncingScrollPhysics(),
                              itemCount: messages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final ChatMessage message = messages[index];
                                return MessageItem(chatMessage: message);
                              }),
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification) {
                              this._isEnd = _scrollController.offset >=
                                  _scrollController.position.maxScrollExtent;
                            }
                            return true;
                          },
                        );
                      }),
                    ),
                    Obx(() {
                      final typingUsers = SocketClient.instance.typingUsers;
                      // Comprobando que alguien esté escribiendo
                      if (typingUsers.values.length > 0) {
                        // Mostrar texto del último usuario escribiendo
                        final String username = typingUsers.values.last;
                        return Text('$username is typing',
                            style: TextStyle(color: Colors.black26));
                      }
                      return Container(height: 0.0);
                    }),
                    InputChat(onSend: this._goToEnd)
                  ],
                )),
            ValueListenableBuilder<int>(
              builder: (BuildContext context, int value, Widget child) {
                if (value == 0) {
                  return Container();
                } else {
                  return Positioned(
                    right: 10.0,
                    bottom: 120.0,
                    child: FloatingActionButton(
                      onPressed: this._goToEnd,
                      backgroundColor: Colors.white,
                      child: Text(value.toString()),
                    ),
                  );
                }
              },
              valueListenable: _counterNotifier,
            )
          ],
        ),
      ),
    );
  }
}
