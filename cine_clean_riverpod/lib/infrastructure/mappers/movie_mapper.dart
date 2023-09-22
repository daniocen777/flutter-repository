// Transformar los modelos (volátil que dependen del API) a entidades (domain)

import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_detail.dart';
import '../models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movieDB) => Movie(
        adult: movieDB.adult,
        backdropPath: (movieDB.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
            : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
        genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity,
        posterPath: (movieDB.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
            : 'https://ih1.redbubble.net/image.1027712254.9762/pp,840x830-pad,1000x1000,f8f8f8.u2.jpg',
        releaseDate: (movieDB.releaseDate != null)
            ? movieDB.releaseDate!
            : DateTime.now(),
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDB) => Movie(
        adult: movieDB.adult,
        backdropPath: (movieDB.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
            : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
        genreIds: movieDB.genres.map((e) => e.name).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity,
        posterPath: (movieDB.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
            : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
        releaseDate: movieDB.releaseDate,
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount,
      );
}
