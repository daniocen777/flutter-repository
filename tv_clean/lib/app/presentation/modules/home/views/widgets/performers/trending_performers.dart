import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/either/either.dart';
import '../../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../../domain/models/performer/performer.dart';
import '../../../../../global/widgets/request_failed.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/state/home_state.dart';
import 'performer_tile.dart';

typedef EitherListPerformer = Either<HttpRequestFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();
    final performers = controller.state.performers;
    return Expanded(
        child: performers.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      failed: () => RequestFailed(onRetry: () {
        controller.loadPerformers(performers: const PerformersState.loading());
      }),
      loaded: (list) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            padEnds: true, // Alinear a la izquierda => false
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) {
              final performer = list[index];
              return PerformerTile(performer: performer);
            },
          ),
          Positioned(
            bottom: 30.0,
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (_, __) {
                final int currentCard = _pageController.page?.toInt() ?? 0;
                return Row(
                    children: List.generate(
                        list.length,
                        (index) => Icon(
                              Icons.circle,
                              color: currentCard == index
                                  ? Colors.blue
                                  : Colors.white30,
                              size: 14.0,
                            )));
              },
            ),
          ),
          const SizedBox(height: 10.0)
        ],
      ),
    ));
  }
}
