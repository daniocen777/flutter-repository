import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';
import '../controller/state/home_state.dart';
import 'widgets/movies_and_series/trending_list.dart';
import 'widgets/performers/trending_performers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = HomeController(HomeState(loading: true),
            trendingRepository: context.read());

        controller.init();
        return controller;
      },
      child: Scaffold(
        body: SafeArea(
            child: LayoutBuilder(
          builder: (_, BoxConstraints constraints) => RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child:  const Column(
                  children: [
                    SizedBox(height: 10.0),
                    TrendingList(),
                    SizedBox(height: 10.0),
                    TrendingPerformers()
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
