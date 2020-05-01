import 'package:flutter/material.dart';
import 'package:food_delivery/src/data/data.dart';
import 'package:food_delivery/src/models/order.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cart.forEach(
        (Order order) => totalPrice += order.quantity + order.food.price);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${currentUser.cart.length})'),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            Order order = currentUser.cart[index];
            return _buildCartItem(order);
          } else {
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Estimated  Deleivery Time:',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600)),
                      Text('25 min.',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total Cost:',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600)),
                      Text('\$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(
                    height: 80.0,
                  )
                ],
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.0,
            color: Colors.grey,
          );
        },
      ),
      bottomSheet: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, -1), blurRadius: 6.0)
            ]),
        child: Center(
          child: FlatButton(
              onPressed: () => print('Checkout'),
              child: Text('CHECKOUT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0))),
        ),
      ),
    );
  }

  Widget _buildCartItem(Order order) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 170.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 150.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(order.food.imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15.0)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    order.food.name,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    order.restaurant.name,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 90.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 0.8, color: Colors.black54)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => print('Menos'),
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(order.quantity.toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 15.0,
                        ),
                        GestureDetector(
                          onTap: () => print('Más'),
                          child: Text('+',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Text('\$${order.quantity * order.food.price}',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
