import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomtextField extends StatelessWidget {
  final bool obscureText;
  final String iconPath;
  final String initialValue;
  final String hintText;
  final String labelText;
  final Function(String)? onFieldSubmitted;

  const CustomtextField(
      {Key? key,
      required this.iconPath,
      this.onFieldSubmitted,
      this.initialValue = '',
      required this.hintText,
      required this.labelText,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        obscureText: this.obscureText,
        initialValue: this.initialValue,
        keyboardAppearance: Brightness.light,
        decoration: InputDecoration(
            hintText: this.hintText,
            labelText: this.labelText,
            prefixIcon: Container(
              padding: EdgeInsets.all(10.0),
              width: 70.0,
              height: 40.0,
              child: SvgPicture.asset(this.iconPath, color: Colors.black54),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            )),
        textInputAction: TextInputAction.send,
        onFieldSubmitted: this.onFieldSubmitted,
      ),
    );
  }
}
