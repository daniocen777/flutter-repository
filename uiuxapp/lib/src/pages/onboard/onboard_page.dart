import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../pages/onboard/onboard_controller.dart';
import '../../pages/onboard/widgets/bottom_controll.dart';

import 'widgets/slider.dart';

class OnboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = OnboardController();
        /* Cuando la página sea renderizada */
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          controller.afterFirstLayout();
        });
        return controller;
      },
      builder: (context, __) => Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                OnboardSlider(),
                SizedBox(
                  height: 40.0,
                ),
                BottomControll()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
