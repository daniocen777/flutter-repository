import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/either/either.dart';
import '../../../../../../domain/enums.dart';
import '../../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../../domain/models/media/media.dart';
import '../../../../../../domain/repositories/trending_repository.dart';
import 'trending_tile.dart';
import 'trending_time_window.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  TrendingRepository get _repository => context.read();
  late Future<EitherListMedia> _future;
  TimeWindow _timeWindow = TimeWindow.day;

  @override
  void initState() {
    super.initState();
    // Provider.of<TrendingRepository>(constex, listen: false);
    _future = _repository.getMoviesAndSeries(_timeWindow);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
            timeWindow: _timeWindow,
            onChanged: (timeWindow) {
              setState(() {
                _timeWindow = timeWindow;
                _future = _repository.getMoviesAndSeries(_timeWindow);
              });
            }),
        const SizedBox(height: 10.0),
        AspectRatio(
            aspectRatio: 16 / 8,
            child: LayoutBuilder(
              builder: (_, BoxConstraints constraints) {
                final width = constraints.maxHeight * 0.65;
                return Center(
                  child: FutureBuilder<EitherListMedia>(
                    key: ValueKey(_future),
                    future: _future,
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return snapshot.data!.when(
                          left: (failure) => Text(failure.toString()),
                          right: (list) {
                            return ListView.separated(
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
                            );
                          });
                    },
                  ),
                );
              },
            )),
      ],
    );
  }
}
