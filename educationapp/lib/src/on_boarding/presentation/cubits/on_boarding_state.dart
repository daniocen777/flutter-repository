part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

class CachingFirstTimerState extends OnBoardingState {
  const CachingFirstTimerState();
}

class CheckingIfUserIsFirstTimerState extends OnBoardingState {
  const CheckingIfUserIsFirstTimerState();
}

class CheckIfUserIsFirstTimerState extends OnBoardingState {
  const CheckIfUserIsFirstTimerState();
}

class UserCachedState extends OnBoardingState {
  const UserCachedState();
}

class OnBoardingStatus extends OnBoardingState {
  const OnBoardingStatus({required this.isFirstTimer});

  final bool isFirstTimer;

  @override
  List<bool> get props => [isFirstTimer];
}

class OnBoardingErrorState extends OnBoardingState {
  const OnBoardingErrorState(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
