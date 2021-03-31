import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import '../../utils/colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final bool? isMe;

  const MessageBubble(
      {Key? key, this.message = '', this.isMe, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = new Responsive.of(context);

    return Row(
      mainAxisAlignment:
          (isMe!) ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: _responsive.wp(40.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: (isMe!) ? primaryColor : secondColorLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft:
                  (!isMe!) ? Radius.circular(0.0) : Radius.circular(12.0),
              bottomRight:
                  (isMe!) ? Radius.circular(0.0) : Radius.circular(12.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: (this.isMe!)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(this.username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (this.isMe!) ? Colors.white : Colors.black)),
              Text(
                this.message,
                style: TextStyle(
                    color: (this.isMe!) ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w300),
                textAlign: (this.isMe!) ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
