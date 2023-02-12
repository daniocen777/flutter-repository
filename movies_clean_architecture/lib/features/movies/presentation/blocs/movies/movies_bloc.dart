import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_clean_architecture/core/errors/failures.dart';
import 'package:movies_clean_architecture/core/strings/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie.dart';
import 'package:movies_clean_architecture/features/movies/domain/usercases/get_movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUserCase getMovies;

  MoviesBloc({required this.getMovies}) : super(MoviesInitial()) {
    on<MoviesEvent>((event, emit) async {
      if (event is GetAllMoviesEvent) {        
        emit(LoadingMoviesState());
        final failureOrMovies = await getMovies();
        emit(_mapFailureOrMoviesToState(failureOrMovies));
      }
    });
  }

  MoviesState _mapFailureOrMoviesToState(Either<Failure, List<Movie>> either) {
    return either.fold(
        (failure) => ErrorMoviesState(message: _mapFailureToMessage(failure)),
        (movies) => LoadedMoviesState(movies: movies));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offLineFailureMessage;
      default:
        return "Unexpected Error , Please try again later";
    }
  }
}
