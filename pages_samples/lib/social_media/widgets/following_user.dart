import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/user_model.dart';

class FollowingUsers extends StatelessWidget {
  const FollowingUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          child: Text('Seguidores',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0))),
      Container(
          height: 80.0,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              padding: EdgeInsets.only(left: 10.0),
              itemBuilder: (BuildContext context, int index) {
                User user = users[index];
                return GestureDetector(
                    onTap: () => print('Seguidor'),
                    child: Container(
                        width: 60.0,
                        height: 60.0,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2.0,
                                color: Theme.of(context).primaryColor),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0)
                            ]),
                        child: ClipOval(
                            child: Image(
                                width: 60.0,
                                height: 60.0,
                                image: AssetImage(user.profileImageUrl!),
                                fit: BoxFit.cover))));
              }))
    ]);
  }
}
