part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class LoadingMoviesState extends MoviesState {}

class LoadedMoviesState extends MoviesState {
  final List<Movie> movies;

  const LoadedMoviesState({required this.movies});

  @override
  List<Object> get props => [movies];
}

class ErrorMoviesState extends MoviesState {
  final String message;

  const ErrorMoviesState({required this.message});

  @override
  List<Object> get props => [message];
}
