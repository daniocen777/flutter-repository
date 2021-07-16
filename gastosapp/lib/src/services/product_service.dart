import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gastosapp/src/models/product.dart';

class ProductService {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async {
    QuerySnapshot productsSnapshot = await products.orderBy('name').get();
    List<Product> productsList = [];

    productsSnapshot.docs.forEach((QueryDocumentSnapshot element) {
      final Product product = productFromJson(jsonEncode(element.data()));
      productsList.add(product);
    });

    return productsList;
  }

  Future<bool> addProduct(Product product) async {
    bool ok = false;
    final productToSend = json.decode(productToJson(product));

    products.add(productToSend).then((DocumentReference doc) {
      ok = true;
    }).catchError((onError) {});

    return ok;
  }
}
