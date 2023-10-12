// Quitar meta  y usar flutter_bloc en vex de bloc
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counter: 5, transactionCount: 0));

  void increaseBy(int value) {
    emit(state.copyWith(
        counter: state.counter + 1,
        transactionCount: state.transactionCount + 1));
  }

  void reset(int value) {
    emit(state.copyWith(
        counter: 0, transactionCount: state.transactionCount + 1));
  }
}
