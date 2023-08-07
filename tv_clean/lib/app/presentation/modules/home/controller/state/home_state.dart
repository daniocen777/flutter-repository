import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/models/performer/performer.dart';

part 'home_state.freezed.dart';

// Unir los estados
@freezed
class Homestate with _$Homestate {
  factory Homestate({
    @Default(MoviesAndSeriesState.loading(TimeWindow.day))
        MoviesAndSeriesState moviesAndSeries,

    ///
    @Default(PerformersState.loading())
        PerformersState performers,
  }) = _Homestate;
}

// Estado para las películas y series (frc)
@freezed
class MoviesAndSeriesState with _$MoviesAndSeriesState {
  // Union type y sealed
  const factory MoviesAndSeriesState.loading(TimeWindow timeWindow) =
      MoviesAndSeriesStateLoading;
  const factory MoviesAndSeriesState.failed(TimeWindow timeWindow) =
      MoviesAndSeriesStateFailed;
  const factory MoviesAndSeriesState.loaded({
    required TimeWindow timeWindow,
    required List<Media> list,
  }) = MoviesAndSeriesStateLoaded;
}

// Estado para los actores (frc)
@freezed
class PerformersState with _$PerformersState {
  const factory PerformersState.loading() = PerformersStateLoading;
  const factory PerformersState.failed() = PerformersStateFailed;
  const factory PerformersState.loaded(
    List<Performer> list,
  ) = PerformersStateLoaded;
}
