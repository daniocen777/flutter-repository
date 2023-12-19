part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncreaseEvent extends CounterEvent {
  const IncreaseEvent();

  @override
  List<Object> get props => [];
}
