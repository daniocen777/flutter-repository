import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final Icon icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;

  const CustomInput(
      {Key key,
      @required this.icon,
      @required this.placeholder,
      @required this.textEditingController,
      this.textInputType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5.0, left: 5.0, bottom: 5.0, right: 20.0),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 5.0)
            ],
            borderRadius: BorderRadius.circular(30.0)),
        child: TextField(
          controller: this.textEditingController,
          autocorrect: false,
          obscureText: this.isPassword,
          keyboardType: this.textInputType,
          decoration: InputDecoration(
              prefixIcon: this.icon,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: this.placeholder),
        ));
  }
}
