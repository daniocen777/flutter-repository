import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ecommerceapp/providers/dark_theme_provider.dart';
import 'package:ecommerceapp/widgets/custom_button.dart';
import 'package:ecommerceapp/consts/colors.dart';

class EmptyCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _darkThemeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/emptycart.png'))),
            ),
            Text('El carrito está vacío',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _darkThemeProvider.darkTheme
                        ? Theme.of(context).disabledColor
                        : subTitle,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 30.0,
            ),
            CustomButton(
              label: 'Comprar ahora',
              onPressed: () => print('Comprar'),
            )
          ],
        ),
      ),
    );
  }
}
