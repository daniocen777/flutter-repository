import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/src/libs/auth.dart';

class MyAvatar extends StatelessWidget {
  final VoidCallback onPressed;

  const MyAvatar({Key key, @required this.onPressed}) : super(key: key);

  Widget _getAlias(String displayName) {
    final List<String> temporal = displayName.split(' ');
    String alias = '';
    if (temporal.length > 0) {
      alias = temporal[0][0];
      if (temporal.length == 2) {
        alias += temporal[1][0];
      }
    }
    return Center(
        child: Text(alias,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: Auth.instance.user,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          final FirebaseUser user = snapshot.data;

          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: this.onPressed,
            child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Color(0xfff50057),
                child: (user.photoUrl != null)
                    ? ClipOval(
                        child: Image.network(
                        user.photoUrl,
                        width: 58.0,
                        height: 58.0,
                        fit: BoxFit.contain,
                      ))
                    : _getAlias(user.displayName)),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al cargar datos'));
        }

        return Center(child: CupertinoActivityIndicator());
      },
    );
  }
}
