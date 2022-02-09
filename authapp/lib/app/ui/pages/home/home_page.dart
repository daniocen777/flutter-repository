import 'package:authapp/app/ui/pages/home/widwets/home_tab_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/meedu.dart';

import 'package:authapp/app/ui/pages/home/home_controller.dart';
import 'package:authapp/app/ui/pages/home/tabs/home/home_tab.dart';
import 'package:authapp/app/ui/pages/home/tabs/profile/profile_tab.dart';

final homeProvider = SimpleProvider(
  (_) => HomeController(),
);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<HomeController>(
      provider: homeProvider,
      builder: (_, controller) {
        return Scaffold(
          bottomNavigationBar: HomeTabBar(),
          body: SafeArea(
              child: TabBarView(
                  controller: controller.tabController,
                  children: const [HomeTab(), ProfileTab()])),
        );
      },
    );
  }
}
