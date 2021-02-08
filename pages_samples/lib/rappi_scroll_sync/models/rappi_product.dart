import 'package:meta/meta.dart' show required;

class RappiProduct {
  final String name;
  final String description;
  final double price;
  final String image;

  const RappiProduct(
      {@required this.name,
      @required this.description,
      @required this.price,
      this.image});
}
