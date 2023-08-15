// frf
import 'package:freezed_annotation/freezed_annotation.dart';

import '../genre/genre.dart';
import '../media/media.dart';
import '../typedefs.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  // Para funciones personalizadas, se encesita constructgor privado
  const Movie._();

  const factory Movie({
    required int id,
    required List<Genre> genres,
    required String overview,
    required int runtime,
    @JsonKey(name: 'release_date') required DateTime releaseDate,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(readValue: readTitleValue) required String title,
    @JsonKey(readValue: readOriginalTitleValue) required String originalTitle,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'poster_path') required String posterPath,
  }) = _Movie;

  factory Movie.fromJson(Json json) => _$MovieFromJson(json);

  Media toMedia() {
    return Media(
        id: id,
        overview: overview,
        title: title,
        originalTitle: originalTitle,
        posterPath: posterPath,
        voteAverage: voteAverage,
        type: MediaType.movie);
  }
}

Object? readTitleValue(Map map, String _) {
  return map['title'] ?? map['name'];
}

Object? readOriginalTitleValue(Map map, String _) {
  return map['original_title'] ?? map['original_name'];
}
