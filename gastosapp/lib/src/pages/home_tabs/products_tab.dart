import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastosapp/src/blocs/product/product_bloc.dart';
import 'package:websafe_svg/websafe_svg.dart';
/* import '../../utils/responsive.dart'; */
import '../../widgets/product_card_widget.dart';
/* import '../../widgets/appbar_widget.dart'; */

class ProductsTab extends StatelessWidget {
  const ProductsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final Responsive _responsive = Responsive.of(context); */

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, state) {
        if (state.products.length == 0) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                WebsafeSvg.asset(
                  'assets/icons/box.svg',
                  width: 40.0,
                ),
                SizedBox(height: 10.0),
                Text('No hay productos para mostrar')
              ],
            ),
          );
        }
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = state.products[index];
              return ProductCard(
                product: product,
              );
            });
      },
      buildWhen: (prevState, newState) =>
          prevState.products.length != newState.products.length,
    );
  }
}
