import 'package:flutter/material.dart';
import 'package:shoes_app/src/helpers/helpers.dart';
import 'package:shoes_app/src/widgets/custom_widgets.dart';

class ZapatoPage extends StatelessWidget {
  const ZapatoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cambiarStatusDark();
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomAppBar(
            texto: 'For you',
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Hero(tag: 'zapato_1', child: ZapatoSizePreview()),
                  ZapatoDescripcion(
                      title: 'Nike Air Max 720',
                      descript:
                          "The Nike Air Max 720 goes bigger than ever before with Nike's taller Air unit yet, offering more air underfoot for unimaginable, all-day comfort. Has Air Max gone too far? We hope so.")
                ],
              ),
            ),
          ),
          AgregarCarritoBoton(monto: 180.0)
        ],
      ),
    );
  }
}
