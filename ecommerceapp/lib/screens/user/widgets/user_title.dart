import 'package:flutter/material.dart';

class UserTitle extends StatelessWidget {
  final String title;

  const UserTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0));
  }
}
