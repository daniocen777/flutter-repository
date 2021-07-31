import 'package:ecommerceapp/consts/colors.dart';
import 'package:ecommerceapp/screens/cart/widgets/item_cart.dart';
import 'package:ecommerceapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:ecommerceapp/consts/my_icons.dart';

class CartHomePage extends StatefulWidget {
  @override
  _CartHomePageState createState() => _CartHomePageState();
}

class _CartHomePageState extends State<CartHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          actions: [
            IconButton(
                icon: MyAppIcons.delete, onPressed: () => print('delete item'))
          ],
        ),
        bottomSheet: Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                      label: 'Verificar',
                      onPressed: () => print('VERIFICAR PRODUCTO')),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      'S/ 32.23',
                      style: TextStyle(
                          color: cartColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return ItemCart();
            },
          ),
        ));
  }
}
