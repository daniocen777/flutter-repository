import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final Icon icon;
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
      required this.icon,
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
      obscureText: obscureText,
      initialValue: initialValue,
      keyboardType: textInputType,
      keyboardAppearance: Brightness.light,
      validator: validator,
      focusNode: focusNode,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Container(
            padding: const EdgeInsets.all(10.0),
            width: 70.0,
            height: 40.0,
            child: icon,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
      textInputAction: TextInputAction.send,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
