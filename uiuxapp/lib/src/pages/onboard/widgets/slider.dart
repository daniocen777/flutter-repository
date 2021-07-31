import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uiuxapp/src/utils/font_style.dart';

import '../../../data/models/onboard_item.dart';
import '../onboard_controller.dart';

class OnboardSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<OnboardController>(context, listen: false);

    return Expanded(
        child: PageView(
            physics: BouncingScrollPhysics(),
            controller: _controller.pageController,
            children: List.generate(_controller.items.length, (index) {
              final OnboardItem item = _controller.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  child: Column(
                    children: [
                      Expanded(child: SvgPicture.asset(item.image)),
                      Text(item.title,
                          textAlign: TextAlign.center, style: FontStyle.title),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        item.description,
                        textAlign: TextAlign.center                        
                      ),
                    ],
                  ),
                ),
              );
            })));
  }
}
