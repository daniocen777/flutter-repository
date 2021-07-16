import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final String iconPath;
  final TextInputType textInputType;
  final String initialValue;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;

  const CustomTextFormField(
      {Key? key,
      required this.iconPath,
      this.textInputType = TextInputType.text,
      this.validator,
      this.onFieldSubmitted,
      this.initialValue = '',
      this.hintText = '',
      this.labelText = '',
      this.focusNode,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: this.obscureText,
      initialValue: this.initialValue,
      keyboardType: this.textInputType,
      keyboardAppearance: Brightness.light,
      validator: this.validator,
      focusNode: this.focusNode,
      decoration: InputDecoration(
          hintText: this.hintText,
          labelText: this.labelText,
          prefixIcon: Container(
            padding: EdgeInsets.all(10.0),
            width: 70.0,
            height: 40.0,
            child: WebsafeSvg.asset(this.iconPath, color: Colors.black54),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      textInputAction: TextInputAction.send,
      onFieldSubmitted: this.onFieldSubmitted,
    );
  }
}
