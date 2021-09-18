import 'package:facebookui/config/palette.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final IconData icon;

  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.color = Colors.white,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            side: MaterialStateProperty.all(
                BorderSide(width: 3.0, color: Colors.blueAccent))),
        onPressed: this.onTap,
        child: Row(
          children: [
            ShaderMask(
              shaderCallback: (rect) =>
                  Palette.createRoomGradient.createShader(rect),
              child: Icon(
                this.icon,
                color: Colors.white,
                size: 35.0,
              ),
            ),
            SizedBox(width: 4.0),
            Text(this.text, style: TextStyle(color: Palette.facebookBlue))
          ],
        ));
  }
}
