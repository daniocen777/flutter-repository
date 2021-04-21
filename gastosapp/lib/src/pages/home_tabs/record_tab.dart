import 'package:flutter/material.dart';
import 'package:gastosapp/src/widgets/product_card_widget.dart';

class RecordTab extends StatelessWidget {
  const RecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        ProductCard(
          name: 'Enero',
          price: 12.20,
          isAccumulated: true,
        ),
        ProductCard(
          name: 'Febrero',
          price: 40.20,
          isAccumulated: true,
        ),
        ProductCard(
          name: 'Marzo',
          price: 10.20,
          isAccumulated: true,
        ),
        ProductCard(
          name: 'Abril',
          price: 51.20,
          isAccumulated: true,
        ),
      ],
    );
  }
}
