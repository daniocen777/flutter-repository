import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final IconData iconPath;
  final String initialValue;
  final String hintText;
  final String labelText;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const CustomTextField(
      {super.key,
      required this.iconPath,
      this.onFieldSubmitted,
      this.initialValue = '',
      this.hintText = '',
      this.labelText = '',
      this.focusNode,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialValue,
      keyboardAppearance: Brightness.light,
      focusNode: focusNode,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Container(
            padding: const EdgeInsets.all(10.0),
            width: 70.0,
            height: 40.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      textInputAction: TextInputAction.send,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
