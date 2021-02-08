import 'package:meta/meta.dart' show required;
import 'package:pages_samples/rappi_scroll_sync/models/rappi_product.dart';

class RappyCategory {
  final String name;
  final List<RappiProduct> products;

  const RappyCategory({@required this.name, @required this.products});
}
