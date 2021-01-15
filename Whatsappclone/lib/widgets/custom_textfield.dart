import 'package:Whatsappclone/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final String hintText;
  final TextEditingController textEditingController;

  const CustomTextField(
      {Key key,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      @required this.icon,
      @required this.hintText,
      @required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 330,
        padding: EdgeInsets.only(top: 5.0, left: 5.0, bottom: 5.0, right: 20.0),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black87.withOpacity(0.5),
                  offset: Offset(0, 5),
                  blurRadius: 5.0)
            ]),
        child: TextField(
          controller: textEditingController,
          autocorrect: false,
          keyboardType: this.keyboardType,
          obscureText: this.obscureText,
          decoration: InputDecoration(
              prefixIcon: Icon(
                this.icon,
                color: PRIMARY_COLOR,
              ),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: hintText),
        ));
  }
}
