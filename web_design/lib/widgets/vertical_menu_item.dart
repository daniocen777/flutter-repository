import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';
import '../widgets/custom_text.dart';

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const VerticalMenuItem(
      {Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.onTap,
        onHover: (value) {
          value
              ? menuController.onHover(this.itemName)
              : menuController.onHover('Not hovering');
        },
        child: Obx(() => Container(
            color: menuController.isHovering(this.itemName)
                ? lightGrey.withOpacity(0.1)
                : Colors.transparent,
            child: Row(children: [
              Visibility(
                visible: menuController.isHovering(this.itemName) ||
                    menuController.isActive(this.itemName),
                child: Container(
                  width: 3.0,
                  height: 72.0,
                  color: dark,
                ),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: menuController.returnIconFor(this.itemName)),
                  !menuController.isActive(this.itemName)
                      ? Flexible(
                          child: CustomText(
                          text: this.itemName,
                          color: menuController.isHovering(this.itemName)
                              ? dark
                              : lightGrey,
                        ))
                      : Flexible(
                          child: CustomText(
                              text: this.itemName,
                              size: 18.0,
                              color: dark,
                              fontWeight: FontWeight.bold))
                ],
              ))
            ]))));
  }
}
