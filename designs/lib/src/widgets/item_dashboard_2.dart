import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemDashboard2 extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color titleColor;
  final Function onPress;

  const ItemDashboard2(
      {Key key,
      this.imageUrl,
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
            SvgPicture.asset(
              this.imageUrl,
              width: 60.0,
              height: 60.0,
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
