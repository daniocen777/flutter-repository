import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoopCard extends StatelessWidget {
  final String name;
  final int quantity;
  final double? cost;
  /* TODO: producto */
  const ShoopCard({Key? key, required this.name, this.quantity = 1, this.cost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 30.0, top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Text(
                    this.name,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cantidad'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black,
                          ),
                          iconSize: 25.0,
                          onPressed: () => print('+1')),
                      Text(
                        '${this.quantity}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 25.0,
                          onPressed: () => print('-1')),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Text('Precio: S/34.0'),
                ],
              ),
            ),
          ],
        ));
  }
}
