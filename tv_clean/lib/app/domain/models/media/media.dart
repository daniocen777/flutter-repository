import 'package:freezed_annotation/freezed_annotation.dart';

import '../typedefs.dart';

part 'media.freezed.dart';
part 'media.g.dart'; // json_serializable

@freezed
class Media with _$Media {
  factory Media({
    required int id,
    required String title,
    required String overview,
    @JsonKey(name: 'original_title') required String originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required String voteAverage,
    @JsonKey(name: 'media_type') required String type,
  }) = _Media;

  // Usando typedefs de nombre Json
  factory Media.fromJson(Json json) => _$MediaFromJson(json);
}
