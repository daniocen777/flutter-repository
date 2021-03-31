import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/responsive.dart';

class TitleWidget extends StatelessWidget {
  final String titulo;

  const TitleWidget({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Text(this.titulo,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: responsive.ip(4.5),
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
