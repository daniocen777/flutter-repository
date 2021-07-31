import 'package:flutter/material.dart';
import 'package:pages_samples/rappi_scroll_sync/models/rappi_category.dart';
import 'package:pages_samples/rappi_scroll_sync/utils/colors.dart';

class RappiCategoryItem extends StatelessWidget {
  final double? categoryHight;
  final RappiCategory? category;

  const RappiCategoryItem({Key? key, this.categoryHight, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.categoryHight,
      alignment: Alignment.centerLeft,
      child: Text(category!.name,
          style: TextStyle(
              color: BLUE_COLOR, fontSize: 14.0, fontWeight: FontWeight.w700)),
    );
  }
}
