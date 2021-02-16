import 'package:meta/meta.dart' show required;
import 'package:pages_samples/rappi_scroll_sync/models/rappi_product.dart';

class RappiCategory {
  final String name;
  final List<RappiProduct> products;

  const RappiCategory({@required this.name, @required this.products});
}
