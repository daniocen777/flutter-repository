part of 'memes_bloc_bloc.dart';

abstract class MemesBlocEvent extends Equatable {
  const MemesBlocEvent();

  @override
  List<Object> get props => [MemesBlocEvent];
}

class GetmemesEvent extends MemesBlocEvent {}
