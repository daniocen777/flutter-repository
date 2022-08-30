import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'tip_event.dart';
part 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  TipBloc() : super(const TipInitialState()) {
    on<AmountPerPersonEvent>((event, emit) {
      emit(state.copyWith(amountPerPerson: event.total / event.quantity));
    });
  }
}
