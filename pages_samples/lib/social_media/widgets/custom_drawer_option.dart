import 'package:flutter/material.dart';

class CustomDraweroption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const CustomDraweroption(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(this.icon),
      title: Text(this.title,
          style: TextStyle(
            fontSize: 15.0,
          )),
      onTap: this.onTap,
    );
  }
}
