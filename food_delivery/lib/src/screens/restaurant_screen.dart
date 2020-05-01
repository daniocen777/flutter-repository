import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/widgets/rating_stars.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;
  RestaurantScreen({Key key, this.restaurant}) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: widget.restaurant.imageUrl,
                child: Image(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  image: AssetImage(widget.restaurant.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 30.0,
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context)),
                    IconButton(
                        icon: Icon(Icons.favorite_border),
                        iconSize: 30.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: () => print('Like')),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.restaurant.name,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                            Text('0.2 miles away',
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                        RatingStars(
                          rating: widget.restaurant.rating,
                        ),
                        SizedBox(height: 6.0),
                        Text(widget.restaurant.address,
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text('Reviews',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          onPressed: () => print('Review')),
                      FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text('Contact',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          onPressed: () => print('Review'))
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text('Menu',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                  ),
                  Container(
                      width: 300,
                      height: 400,
                      child: GridView.count(
                          padding: EdgeInsets.all(10.0),
                          crossAxisCount: 2,
                          children: List.generate(widget.restaurant.menu.length,
                              (index) {
                            Food food = widget.restaurant.menu[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildMenuIten(food),
                            );
                          })))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuIten(Food food) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 150.0,
            height: 175.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(food.imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15.0)),
          ),
          Container(
            width: 150.0,
            height: 175.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: <Color>[
                      Colors.black.withOpacity(0.3),
                      Colors.black87.withOpacity(0.3),
                      Colors.black54.withOpacity(0.3),
                      Colors.black38.withOpacity(0.3),
                    ],
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                      0.9
                    ])),
          ),
          Positioned(
            bottom: 65.0,
            child: Column(
              children: <Widget>[
                Text(
                  food.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 1.2),
                ),
                Text('\$ ${food.price}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1.2)),
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () {
                    print('Add');
                  }),
            ),
          )
        ],
      ),
    );
  }
}
