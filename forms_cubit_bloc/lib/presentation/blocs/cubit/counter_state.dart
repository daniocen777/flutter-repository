part of 'counter_cubit.dart';

// Quitar decorador @immutable
/* sealed class CounterState {}

final class CounterInitial extends CounterState {} */

class CounterState {
  final int counter;
  final int transactionCount;

  CounterState({required this.counter, required this.transactionCount});

  CounterState copyWith({int? counter, int? transactionCount}) => CounterState(
        counter: counter ?? this.counter,
        transactionCount: transactionCount ?? this.transactionCount,
      );
}
