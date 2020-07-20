import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  ProfileTabPage({Key key}) : super(key: key);

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile'),
    );
  }
}
