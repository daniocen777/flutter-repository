import 'package:ecommerceapp/screens/cart/pages/cart_home_page.dart';
import 'package:flutter/material.dart';

import 'pages/empty_card_page.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List _products = [1];

    return SafeArea(
        child: Container(
            child: _products.isEmpty
                ? EmptyCardPage()
                : Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: CartHomePage()
                  )));
  }
}
