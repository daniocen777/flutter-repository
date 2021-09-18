import 'package:flutter/material.dart';
import 'package:pages_samples/bank_finance/utils/colors.dart';

class TextInput extends StatelessWidget {
  final bool obscureText;
  final String initialValue;
  final String hintText;
  final String labelText;
  final Function(String)? onFieldSubmitted;
  final Widget? suffix;
  final bool filled;
  final FocusNode? focusNode;

  const TextInput(
      {Key? key,
      this.onFieldSubmitted,
      this.initialValue = '',
      this.hintText = '',
      this.labelText = '',
      this.focusNode,
      this.suffix,
      this.filled = false,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.00,
      child: TextFormField(
        obscureText: this.obscureText,
        initialValue: this.initialValue,
        cursorColor: primaryColor,
        focusNode: this.focusNode,
        decoration: InputDecoration(
          fillColor: primaryColor.withOpacity(0.2),
          filled: this.filled,
          hintText: this.hintText,
          labelText: this.labelText,
          suffix: this.suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        textInputAction: TextInputAction.send,
        onFieldSubmitted: this.onFieldSubmitted,
      ),
    );
  }
}
