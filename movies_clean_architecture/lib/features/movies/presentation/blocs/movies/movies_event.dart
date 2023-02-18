part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetAllMoviesEvent extends MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent {
  final int page;

  const GetPopularMoviesEvent({required this.page});

  @override
  List<Object> get props => [page];
}
