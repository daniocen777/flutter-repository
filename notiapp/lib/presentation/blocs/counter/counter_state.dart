part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {
  const CounterInitial();

  @override
  List<Object> get props => [];
}

class CounterFinalState extends CounterState {
  final int finalValue;

  const CounterFinalState({required this.finalValue});

  CounterFinalState copyWith(int? value) {
    return CounterFinalState(finalValue: value ?? finalValue);
  }

  @override
  List<Object> get props => [finalValue];
}
