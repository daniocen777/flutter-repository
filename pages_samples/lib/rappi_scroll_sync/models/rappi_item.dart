import 'package:pages_samples/rappi_scroll_sync/models/rappi_category.dart';
import 'package:pages_samples/rappi_scroll_sync/models/rappi_product.dart';

class RappiItem {
  final RappiCategory? category;
  final RappiProduct? product;
  bool get isCategory => category != null;

  const RappiItem({this.category, this.product});
}
