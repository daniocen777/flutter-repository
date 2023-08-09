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
      create: (_) =>
          HomeController(Homestate(), trendingRepository: context.read())
            ..init(),
      child: Scaffold(
        body: SafeArea(
            child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) => RefreshIndicator(
            onRefresh: () async {
              // Llamar función init del controller
              await context.read<HomeController>().init();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: const Column(
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
