import 'package:flutter/material.dart';
import 'package:web_design/helpers/responsive.dart';
import 'package:web_design/widgets/horizontal_menu_item.dart';
import 'package:web_design/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidwet.isConstomcreen(context)
        ? VerticalMenuItem(itemName: this.itemName, onTap: this.onTap)
        : HorizontalMenuItem(itemName: this.itemName, onTap: this.onTap);
  }
}
