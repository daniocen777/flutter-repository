import 'package:movies_clean_architecture/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {bool? adult,
      String? backdropPath,
      List<int>? genreIds,
      int? id,
      String? originalLanguage,
      String? originalTitle,
      String? overview,
      double? popularity,
      String? posterPath,
      DateTime? releaseDate,
      required String title,
      bool? video,
      double? voteAverage,
      int? voteCount})
      : super(
            adult: adult,
            backdropPath: backdropPath,
            genreIds: genreIds,
            id: id,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount);

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        adult: json['adult'],
        backdropPath: json['backdropPath'],
        genreIds: json['genreIds'],
        id: json['id'],
        originalLanguage: json['originalLanguage'],
        originalTitle: json['originalTitle'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['posterPath'],
        releaseDate: json['releaseDate'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['voteAverage'],
        voteCount: json['voteCount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdropPath': backdropPath,
      'genreIds': genreIds,
      'id': id,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'title': title,
      'video': video,
      'voteAverage': voteAverage,
      'voteCount': voteCount
    };
  }
}
