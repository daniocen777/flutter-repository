import 'package:flutter/material.dart';
import 'package:chatprivado/utils/colors.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String pregunta;
  final String accion;

  const Labels(
      {Key key,
      @required this.ruta,
      @required this.pregunta,
      @required this.accion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Text(this.pregunta,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300)),
            SizedBox(
              height: 5.0,
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, this.ruta),
              child: Text(this.accion,
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }
}
