import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';
import '../controller/state/home_state.dart';
import 'widgets/characters/characters.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            HomeController(HomeStateLoading(), repository: context.read())
              ..init(),
        child: const Scaffold(
          body: SafeArea(
              child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Character(),
                ],
              ),
            ),
          )),
        ));
  }
}
