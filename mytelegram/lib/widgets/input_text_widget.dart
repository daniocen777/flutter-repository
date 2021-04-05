import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'package:flutter/services.dart';

class InputText extends StatefulWidget {
  final String iconPath;
  final String placeholder;
  final String initValue;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool Function(String text)? validator;

  const InputText(
      {Key? key,
      required this.iconPath,
      required this.placeholder,
      this.validator,
      required this.initValue,
      this.obscureText = false,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  InputTextState createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  TextEditingController? _textEditingController;
  bool _validationOk = false;

  bool get isOk => _validationOk;
  String get value => _textEditingController!.text;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initValue);
    this.checkValidation();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  void checkValidation() {
    if (widget.validator != null) {
      final bool isOk = widget.validator!(_textEditingController!.text);
      if (_validationOk != isOk) {
        setState(() {
          _validationOk = isOk;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: _textEditingController,
      onChanged: (value) => checkValidation(),
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
      style: TextStyle(fontFamily: 'sans'),
      prefix: Container(
        width: 40.0,
        height: 30.0,
        padding: EdgeInsets.all(2.0),
        child: WebsafeSvg.asset(this.widget.iconPath, color: Color(0xffdddddd)),
      ),
      placeholder: this.widget.placeholder,
      placeholderStyle: TextStyle(fontFamily: 'sans', color: Color(0xffdddddd)),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Color(0xffdddddd)))),
    );
  }
}
