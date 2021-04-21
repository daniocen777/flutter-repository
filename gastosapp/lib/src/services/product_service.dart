import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gastosapp/src/models/product.dart';

class ProductService {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async {
    QuerySnapshot productsSnapshot = await products.get();
    List<Product> productsList = [];

    productsSnapshot.docs.forEach((QueryDocumentSnapshot element) {
      final Product product = productFromJson(jsonEncode(element.data()));
      productsList.add(product);
    });

    return productsList;
  }
}
