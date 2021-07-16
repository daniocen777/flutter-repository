import 'dart:convert';

/* import 'package:cloud_firestore/cloud_firestore.dart'; */

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({this.id, this.name, this.price, this.createAt});

  String? id;
  String? name;
  double? price;
  DateTime? createAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      price: json["price"] == null ? null : json["price"].toDouble(),
      createAt:
          json["createAt"] == null ? null : DateTime.parse(json["createAt"]));

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "createAt": createAt == null ? null : createAt!.toIso8601String()
      };
}
