import 'package:flutter/material.dart';
import 'package:shoes_app/src/widgets/custom_widgets.dart';

class AgregarCarritoBoton extends StatelessWidget {
  final double monto;
  const AgregarCarritoBoton({Key key, this.monto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 20.0),
            Text(
              '\$ $monto',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            BotonNaranja(
              texto: 'Add to cart',
            ),
            SizedBox(width: 20.0)
          ],
        ),
      ),
    );
  }
}
