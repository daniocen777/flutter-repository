import 'package:flutter/material.dart';
import 'package:pages_samples/bank_finance/utils/colors.dart';

class TextInput extends StatelessWidget {
  final bool obscureText;
  final String initialValue;
  final String hintText;
  final String labelText;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const TextInput(
      {Key? key,
      this.onFieldSubmitted,
      this.initialValue = '',
      this.hintText = '',
      this.labelText = '',
      this.focusNode,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: this.obscureText,
      initialValue: this.initialValue,
      cursorColor: primaryColor,
      keyboardAppearance: Brightness.light,
      focusNode: this.focusNode,
      decoration: InputDecoration(
          hoverColor: primaryColor,
          focusColor: primaryColor,
          fillColor: primaryColor,
          hintText: this.hintText,
          labelText: this.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
      textInputAction: TextInputAction.send,
      onFieldSubmitted: this.onFieldSubmitted,
    );
  }
}
