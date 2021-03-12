import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LoginTextFormField extends StatelessWidget {
  final bool obscureText;
  final String iconPath;
  final String initialValue;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final ValueKey valueKey;
  final Function(String) validator;
  final Function(String) onFieldSubmitted;
  final FocusNode focusNode;

  const LoginTextFormField(
      {Key key,
      @required this.iconPath,
      this.validator,
      this.onFieldSubmitted,
      this.initialValue = '',
      this.hintText = '',
      this.labelText = '',
      this.focusNode,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.valueKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: valueKey,
      obscureText: this.obscureText,
      keyboardType: this.textInputType,
      initialValue: this.initialValue,
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
            borderRadius: BorderRadius.circular(20.0),
          )),
      textInputAction: TextInputAction.send,
      onFieldSubmitted: this.onFieldSubmitted,
    );
  }
}
