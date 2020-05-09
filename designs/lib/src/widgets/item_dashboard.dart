import 'package:flutter/material.dart';

class ItemDashboard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color titleColor;
  final Function onPress;

  const ItemDashboard(
      {Key key,
      this.icon,
      this.title,
      this.titleColor = Colors.white,
      @required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(25.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              this.icon,
              size: 40.0,
              color: Colors.white,
            ),
            Text(
              this.title,
              style: TextStyle(color: this.titleColor, fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }
}
