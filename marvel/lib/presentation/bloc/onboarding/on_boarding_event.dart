part of 'on_boarding_bloc.dart';

abstract class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object> get props => [];
}

class NextPageEvent extends OnBoardingEvent {
  const NextPageEvent({this.page = 0});

  final int page;

  @override
  List<Object> get props => [page];
}
