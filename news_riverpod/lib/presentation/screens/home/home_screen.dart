import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/news/states/new_state.dart';
import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __HomeViewState();
}

class __HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(newsProvider.notifier).loadNews();
  }

  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsProvider);
    String message = 'cargnado...';

    if (news is ErrorNewsState) {
      message = 'Error: ${news.message}';
    }

    if (news is LoadedNewState) {
      message = news.articles.length.toString();
    }

    return Center(
      child: Text('Mensaje: $message'),
    );
  }
}
