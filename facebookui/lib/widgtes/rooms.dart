import 'package:flutter/material.dart';

import 'package:facebookui/widgtes/widgets.dart';
import '../widgtes/custom_buttom.dart';
import '../models/models.dart';

class Rooms extends StatelessWidget {
  final List<User> onlineUsers;

  const Rooms({Key? key, required this.onlineUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 65.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        itemCount: this.onlineUsers.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomButton(
                icon: Icons.video_call,
                text: 'Crear Sala\n De Chat',
                onTap: () => print('Sala de chat'),
              ),
            );
          }

          final User user = onlineUsers[index - 1];
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProfileAvatar(
                imageUrl: user.imageUrl,
                isActive: true,
              ));
        },
      ),
    );
  }
}
