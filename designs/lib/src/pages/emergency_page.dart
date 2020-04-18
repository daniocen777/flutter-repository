import 'package:flutter/material.dart';

import 'package:designs/src/widgets/headers_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:designs/src/widgets/boton_gordo.dart';
import 'package:animate_do/animate_do.dart';

/* Para los botnoes gordos */
class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.texto, this.color1, this.color2);
}

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if (MediaQuery.of(context).size.height > 500) {
      isLarge = true;
    } else {
      isLarge = false;
    }

    final items = <ItemBoton>[
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
    ];

    List<Widget> itemMap = items
        .map((item) => FadeInLeft(
              duration: Duration(milliseconds: 300),
              child: BotonGordo(
                  texto: item.texto,
                  icon: item.icon,
                  color1: item.color1,
                  color2: item.color2,
                  onPress: () {
                    print('Holas');
                  }),
            ))
        .toList();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: (isLarge) ? 180.0 : 10.0),
            child: SafeArea(
              child: ListView(
                // BouncingScrollPhysics => Para evitar la acción de android al llegar al final de una lista
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  if (isLarge) SizedBox(height: 80.0),
                  ...itemMap
                ],
              ),
            ),
          ),
          if (isLarge) _Encabezado()
        ],
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconHeader(
          icon: FontAwesomeIcons.plus,
          subtitle: 'Subtítulo',
          title: 'Título',
          colorGradient1: Color(0xff536CF6),
          colorGradient2: Color(0xff66A9F2),
        ),
        Positioned(
            right: 0.0,
            top: 45.0,
            child: RawMaterialButton(
                onPressed: () {},
                shape: CircleBorder(),
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  FontAwesomeIcons.ellipsisV,
                  color: Colors.white,
                )))
      ],
    );
  }
}
