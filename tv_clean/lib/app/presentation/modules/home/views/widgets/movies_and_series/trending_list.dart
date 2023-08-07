import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/either/either.dart';
import '../../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../../domain/models/media/media.dart';
import '../../../../../global/widgets/request_failed.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/state/home_state.dart';
import 'trending_tile.dart';
import 'trending_time_window.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    // Se necesita escuchar los cambios (listen = true)
    // Provider.of(context, listen: true);
    final HomeController controller = context.watch();
    final moviesAndSeries = controller.state.moviesAndSeries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
          timeWindow: moviesAndSeries.timeWindow,
          onChanged: controller.onTimeWindowChanged,
        ),
        const SizedBox(height: 10.0),
        AspectRatio(
            aspectRatio: 16 / 8,
            child: LayoutBuilder(
              builder: (_, BoxConstraints constraints) {
                final width = constraints.maxHeight * 0.65;
                return Center(
                    child: moviesAndSeries.when(
                        loading: (_) => const CircularProgressIndicator(),
                        failed: (_) => RequestFailed(
                            onRetry: () => controller.loadMoviesAndSeries(
                                    moviesAndSeries:
                                        MoviesAndSeriesState.loading(
                                  moviesAndSeries.timeWindow,
                                ))),
                        loaded: (_, list) => ListView.separated(
                              itemCount: list.length,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              itemBuilder: (_, int index) {
                                final media = list[index];
                                return TrendingTile(media: media, width: width);
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10.0),
                            )));
              },
            )),
      ],
    );
  }
}
