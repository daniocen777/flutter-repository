import 'package:flutter/material.dart';
import 'package:gastosapp/src/models/product.dart';
import 'package:websafe_svg/websafe_svg.dart';

/* import 'package:intl/intl.dart'; */

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isAccumulated;

  const ProductCard(
      {Key? key, required this.product, this.isAccumulated = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        this.product.name!,
        style: TextStyle(
            fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      /* - ${DateFormat("dd-MM-yyyy").format(this.product.createAt!)} */
      subtitle: Text(
        'Precio: S/ ${this.product.price}',
        style: TextStyle(
            fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.w500),
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
