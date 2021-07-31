import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../routes/routes.dart';
import '../../../utils/font_style.dart';
import '../../../utils/colors.dart';

import '../../../pages/onboard/onboard_controller.dart';

class BottomControll extends StatelessWidget {
  const BottomControll({
    Key? key,
  }) : super(key: key);

  void _onNext(BuildContext context, OnboardController controller) {
    if (controller.currentPage == 2.0) {
      Navigator.pushReplacementNamed(context, Routes.WELCOME);
    } else {
      controller.pageController!.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Dots(),
          Consumer<OnboardController>(
            builder: (BuildContext context, controller, Widget? child) {
              final double? page = controller.currentPage;
              bool isEnd = page! % 1 == 0 && page == 2.0;
              return CupertinoButton(
                child: Text(isEnd ? 'Comenzar' : 'Siguiente',
                    style:
                        FontStyle.normal.copyWith(fontWeight: FontWeight.w700)),
                onPressed: () {
                  this._onNext(context, controller);
                },
                color: primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              );
            },
          )
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardController>(context);
    return DotsIndicator(
      dotsCount: controller.items.length,
      position: controller.currentPage,
      decorator: DotsDecorator(
          color: Colors.grey.withOpacity(0.4),
          activeColor: primaryColor,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
    );
  }
}
