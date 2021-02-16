import 'package:flutter/widgets.dart';
import 'package:pages_samples/rappi_scroll_sync/models/rappi_category.dart';

class RappiTabCategory {
  final RappiCategory category;
  final bool selected;
  final double offsetFrom; // Para el tab de la categoría
  final double offsetTo; // Para la lista de productos

  RappiTabCategory copyWith(bool selected) => RappiTabCategory(
      category: category,
      selected: selected,
      offsetFrom: offsetFrom,
      offsetTo: offsetTo);

  const RappiTabCategory(
      {@required this.category,
      @required this.selected,
      @required this.offsetFrom,
      @required this.offsetTo});
}
