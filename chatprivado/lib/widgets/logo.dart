import 'package:chatprivado/utils/colors.dart';
import 'package:chatprivado/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({Key key, @required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            SvgPicture.asset('assets/chat.svg',
                width: responsive.wp(50.0), height: responsive.hp(35.0)),
            SizedBox(
              height: 20.0,
            ),
            Text(this.titulo,
                style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: responsive.ip(4.5),
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
