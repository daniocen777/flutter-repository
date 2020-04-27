import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputTextLogin extends StatelessWidget {
  final String iconPath;
  final String placeholder;

  const InputTextLogin(
      {Key key, @required this.iconPath, @required this.placeholder})
      : assert(iconPath != null && placeholder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
      prefix: Container(
        width: 40.0,
        height: 30.0,
        padding: EdgeInsets.all(2.0),
        child: SvgPicture.asset(
          this.iconPath,
          color: Color(0xffcccccc),
        ),
      ),
      placeholder: this.placeholder,
      style: TextStyle(fontFamily: 'sans'),
      placeholderStyle: TextStyle(
        fontFamily: 'sans',
        color: Color(0xffcccccc),
      ),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Color(0xffdddddd)))),
    );
  }
}
