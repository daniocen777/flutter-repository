import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:facebookui/widgtes/profile_avatar.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;
  const CreatePostContainer({Key? key, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      color: Colors.white,
      child: Column(children: [
        Row(children: [
          ProfileAvatar(imageUrl: currentUser.imageUrl),
          const SizedBox(width: 8.0),
          Expanded(
              child: TextField(
                  decoration: InputDecoration.collapsed(
                      hintText: '¿En qué estás pensando?'))),
          const Divider(height: 10.0, thickness: 0.5),
        ]),
        Container(
            height: 40.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                      onPressed: () => print('En vivo'),
                      icon: Icon(CupertinoIcons.videocam,
                          color: Colors.redAccent),
                      label: Text('En vivo')),
                  const VerticalDivider(width: 8.0),
                  TextButton.icon(
                      onPressed: () => print('Fotos'),
                      icon:
                          Icon(CupertinoIcons.photo, color: Colors.greenAccent),
                      label: Text('Fotos')),
                  const VerticalDivider(width: 8.0),
                  TextButton.icon(
                      onPressed: () => print('Llamada'),
                      icon: Icon(CupertinoIcons.phone,
                          color: Colors.deepPurpleAccent),
                      label: Text('Llamada'))
                ]))
      ]),
    );
  }
}
