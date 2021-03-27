import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ydchat/presentation/widgets/chat/single_item_user_chat.dart';
import 'package:ydchat/presentation/widgets/theme/theme.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.commentDots),
        onPressed: () {},
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
            child: Center(
                child: FaIcon(
              FontAwesomeIcons.comments,
              color: Colors.white.withOpacity(0.6),
              size: 60.0,
            )),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('comienza a chatear',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.0, color: Colors.black.withOpacity(0.4))),
            ),
          )
        ],
      ),
    );
  }

  Widget _myChatList() {
    return Expanded(
        child: ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return SingleItemUserChat();
      },
    ));
  }
}
