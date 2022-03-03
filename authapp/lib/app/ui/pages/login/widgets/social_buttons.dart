import 'package:authapp/app/ui/icons/social_media_icons.dart';
import 'package:authapp/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
            color: primaryLightColor,
            iconData: SocialMedia.facebook,
            onPressed: () {}),
        const SizedBox(width: 15.0),
        SocialButton(
            color: Colors.redAccent,
            iconData: SocialMedia.google,
            onPressed: () {})
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final Color color;

  const SocialButton({
    Key? key,
    this.onPressed,
    required this.iconData,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(const Size(50.0, 50.0)),
            elevation: MaterialStateProperty.all(5.0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)))),
        child: SizedBox(width: 40.0, height: 40.0, child: Icon(iconData)));
  }
}
