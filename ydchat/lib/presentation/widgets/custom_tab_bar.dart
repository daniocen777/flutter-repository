import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ydchat/presentation/widgets/theme/theme.dart';

class CustomTabBar extends StatelessWidget {
  final int? index;

  const CustomTabBar({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: primaryColor,
      child: Row(
        children: [
          Container(
            width: 40.0,
            padding: EdgeInsets.only( left: 10.0 ),
            child: FaIcon(
              FontAwesomeIcons.camera,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(text: 'Chats',
            textColor: this.index == 1 ? secondColorLight : Colors.white,
            borderColor: this.index == 1 ? secondColorLight : Colors.transparent,

            ),
          ),
          Expanded(
            child: CustomTabBarButton(text: 'Estados',
             textColor: this.index == 2 ? secondColorLight : Colors.white,
            borderColor: this.index == 2 ? secondColorLight : Colors.transparent,),
          ),
          Expanded(
            child: CustomTabBarButton(text: 'Llamadas',
             textColor: this.index == 3 ? secondColorLight : Colors.white,
            borderColor: this.index == 3 ? secondColorLight : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  const CustomTabBarButton(
      {Key? key,
      required this.text,
      this.borderColor = Colors.transparent,
      this.textColor = Colors.white,
      this.borderWidth = 3.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: this.borderColor, width: this.borderWidth))),
      child: Text(this.text,
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: this.textColor)),
    );
  }
}
