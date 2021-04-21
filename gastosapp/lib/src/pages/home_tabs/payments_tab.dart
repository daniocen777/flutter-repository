import 'package:flutter/material.dart';
import 'package:gastosapp/src/widgets/shoop_card.dart';
/* import '../../utils/responsive.dart'; */

class PaymentsTab extends StatelessWidget {
  const PaymentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final Responsive _responsive = new Responsive.of(context); */
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => Container(
        height: 2.0,
        color: Colors.grey[200],
      ),
      itemBuilder: (BuildContext context, int index) => Dismissible(
        key: Key('ID.$index'),
        background: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_forever_outlined,
                color: Colors.white,
              ),
              Text('Estás quitando este producto', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        onDismissed: (DismissDirection direction) {
          final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: ShoopCard(
          name: 'Producto XXX',
          quantity: 12,
          cost: 45.30,
        ),
      ),
    );
  }
}
