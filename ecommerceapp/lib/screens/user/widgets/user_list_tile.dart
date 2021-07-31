import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  final VoidCallback onTap;

  const UserListTile(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.icon,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          title: Text(this.title),
          subtitle: Text(this.subTitle),
          leading: this.icon,
          onTap: this.onTap,
        ),
      ),
    );
  }
}
