import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_design/constants/controllers.dart';
import 'package:web_design/widgets/side_menu_item.dart';

import '../constants/style.dart';
import '../helpers/responsive.dart';
import '../routing/routes.dart';
import '../widgets/custom_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Container(
        color: light,
        child: ListView(children: [
          if (ResponsiveWidwet.isSmallScreen(context))
            Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: 40.0),
              Row(children: [
                SizedBox(width: _width / 48.0),
                Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Image.asset('assets/icons/logo.png')),
                Flexible(
                    child: CustomText(
                        text: 'Menu',
                        size: 20.0,
                        fontWeight: FontWeight.bold,
                        color: active)),
                SizedBox(width: _width / 48.0),
              ]),
            ]),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItem
                  .map((item) => SideMenuItem(
                      itemName: item,
                      onTap: () {
                        if (item == AUTHENTICATION_PAGE_ROUTE) {
                          // TODO: Ir a autentication
                        }
                        if (!menuController.isActive(item)) {
                          menuController.changeActiveItemTo(item);
                          if (ResponsiveWidwet.isSmallScreen(context))
                            Get.back();
                        }
                      }))
                  .toList())
        ]));
  }
}
