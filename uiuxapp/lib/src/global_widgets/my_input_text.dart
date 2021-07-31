import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uiuxapp/src/utils/colors.dart';

class MyInputText extends StatefulWidget {
  final Widget? prefixIcon;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;

  const MyInputText(
      {Key? key,
      this.prefixIcon,
      this.labelText,
      this.obscureText = false,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.textInputAction,
      this.onSubmitted})
      : super(key: key);

  @override
  MyInputTextState createState() => MyInputTextState();
}

class MyInputTextState extends State<MyInputText> {
  String? _errorText = '';
  bool? _obscureText;

  String? get errorText => _errorText;

  @override
  void initState() {
    super.initState();
    this._obscureText = widget.obscureText;
  }

  void _validate(String text) {
    if (widget.validator != null) {
      _errorText = widget.validator!(text);
      setState(() {});
    }
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  void _visibilityChange() {
    setState(() {
      this._obscureText = !this._obscureText!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: this._validate,
      obscureText: this._obscureText!,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
          prefixIcon: widget.prefixIcon,
          labelText: widget.labelText,
          suffixIcon: widget.obscureText
              ? CupertinoButton(
                  padding: EdgeInsets.all(10.0),
                  minSize: 25.0,
                  child: Icon(this._obscureText!
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: this._visibilityChange)
              : Icon(
                  Icons.check_circle,
                  color: _errorText == null ? primaryColor : Colors.grey,
                )),
    );
  }
}
