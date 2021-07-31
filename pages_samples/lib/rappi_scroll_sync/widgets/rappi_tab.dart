import 'package:flutter/material.dart';
import 'package:pages_samples/rappi_scroll_sync/models/rappi_tab_category.dart';
import 'package:pages_samples/rappi_scroll_sync/utils/colors.dart';

class RappiTabWidget extends StatelessWidget {
  final RappiTabCategory? tabCategory;

  const RappiTabWidget({Key? key, this.tabCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = tabCategory!.selected;
    return Opacity(
        opacity: selected ? 1.0 : 0.5,
        child: Card(
            elevation: selected ? 6.0 : 0.0,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(tabCategory!.category.name,
                    style: TextStyle(
                        color: BLUE_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0)))));
  }
}
