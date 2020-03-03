import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/pages/product_page.dart';

class ProductDetailPage extends StatelessWidget {
  final Product item;
  const ProductDetailPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://192.168.1.7:1337${item.picture['url']}';
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Container(
        // gradientBackground => del product_page
        decoration: gradientBackground,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Hero(
                    tag: item,
                    child: Image.network(pictureUrl,
                        width: orientation == Orientation.portrait ? 600 : 250,
                        height: orientation == Orientation.portrait ? 400 : 200,
                        fit: BoxFit.cover),
                  )),
              Text(item.name, style: Theme.of(context).textTheme.title),
              Text("\$${item.price}", style: Theme.of(context).textTheme.body1),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
                    child: Text(item.description),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
