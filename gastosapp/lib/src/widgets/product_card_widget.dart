import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double? price;
  final bool isAccumulated;

  const ProductCard(
      {Key? key, required this.name, this.price, this.isAccumulated = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        this.name,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        'Precio: ${this.price}',
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
      ),
      trailing: !this.isAccumulated
          ? WebsafeSvg.asset('assets/icons/add-cart.svg', width: 25.0)
          : Container(
              width: 0.0,
              height: 0.0,
            ),
    );
  }
}
