import 'package:flutter/material.dart';
import 'package:food_delivery/src/data/data.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/screens/cart_screen.dart';
import 'package:food_delivery/src/screens/restaurant_screen.dart';
import 'package:food_delivery/src/widgets/rating_stars.dart';
import 'package:food_delivery/src/widgets/recent_orders.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 30.0,
              onPressed: () {
                print('User');
              }),
          title: Text('Food Delevery'),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Cart (${currentUser.cart.length})',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartScreen())))
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(width: 0.8)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            width: 0.8, color: Theme.of(context).primaryColor)),
                    hintText: 'Search food or restaurant',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        print('clear');
                      },
                    )),
              ),
            ),
            RecentOrders(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Nearby Restaurants',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                ),
                _buildRestaurants()
              ],
            )
          ],
        ));
  }

  Widget _buildRestaurants() {
    List<Widget> restaurantsList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantsList.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RestaurantScreen(restaurant: restaurant))),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1.0, color: Colors.grey[200])),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(
                    width: 150.0,
                    height: 150.0,
                    image: AssetImage(restaurant.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(restaurant.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis),
                      RatingStars(rating: restaurant.rating),
                      SizedBox(height: 4.0),
                      Text(restaurant.address,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 4.0),
                      Text('0.2 miles away',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    });

    return Column(children: restaurantsList);
  }
}
