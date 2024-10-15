part of 'on_boarding_bloc.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitialState extends OnBoardingState {
  const OnBoardingInitialState();
}

class OnBoardingNextPageState extends OnBoardingState {
  const OnBoardingNextPageState(this.page);

  final int page;

  @override
  List<Object> get props => [page];
}
