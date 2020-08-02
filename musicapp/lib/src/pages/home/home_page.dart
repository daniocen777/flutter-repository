import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/src/auths/auth.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _getAlias(String displayName) {
    final List<String> temporal = displayName.split(' ');
    String alias = '';
    if (temporal.length > 0) {
      alias = temporal[0][0];
      if (temporal.length == 2) {
        alias += temporal[1][0];
      }
    }
    return Center(child: Text(alias, style: TextStyle(fontSize: 30.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: FutureBuilder<FirebaseUser>(
            future: Auth.instance.user,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                final FirebaseUser user = snapshot.data;

                return ListView(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    CircleAvatar(
                        radius: 40.0,
                        child: (user.photoUrl != null)
                            ? ClipOval(
                                child: Image.network(
                                user.photoUrl,
                                width: 80.0,
                                height: 80.0,
                                fit: BoxFit.contain,
                              ))
                            : _getAlias(user.displayName)),
                    SizedBox(height: 10.0),
                    Text(user.displayName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text(user.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w300)),
                    SizedBox(height: 20.0),
                    CupertinoButton(
                        child: Text('Log Out'),
                        onPressed: () {
                          Auth.instance.logOut(context);
                        })
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error al cargar datos'));
              }

              return Center(child: CupertinoActivityIndicator());
            },
          ),
        ),
      ),
    );
  }
}
