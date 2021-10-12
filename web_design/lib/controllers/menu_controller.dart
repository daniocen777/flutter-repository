import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:web_design/constants/style.dart';
import 'package:web_design/routing/routes.dart';

class MenuController extends GetxController {
  static final instance = Get.find<MenuController>();
  var activeItem = OVERVIEW_PAGE_ROUTE.obs;
  var hoverItem = ''.obs;

  changeActiveItemTo(String itemName) {
    this.activeItem.value = itemName;
  }

  isActive(String itemName) => this.activeItem.value == itemName;
  isHovering(String itemName) => this.hoverItem.value == itemName;

  onHover(String itemName) {
    if (!isActive(itemName)) this.hoverItem.value = itemName;
  }

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case OVERVIEW_PAGE_ROUTE:
        return this._getcustomIcon(Icons.trending_up_outlined, itemName);
      case CLIENTS_PAGE_ROUTE:
        return this._getcustomIcon(Icons.people_alt_outlined, itemName);
      case AUTHENTICATION_PAGE_ROUTE:
        return this._getcustomIcon(Icons.lock_open_outlined, itemName);
      case DRIVERS_PAGE_ROUTE:
        return this._getcustomIcon(Icons.drive_eta_outlined, itemName);
      default:
        return this._getcustomIcon(Icons.exit_to_app_outlined, itemName);
    }
  }

  Widget _getcustomIcon(IconData icon, String itemName) {
    if (!isActive(itemName)) return Icon(icon, size: 22.0, color: dark);

    return Icon(icon,
        size: 22.0, color: isHovering(itemName) ? dark : lightGrey);
  }
}
