part of 'tip_bloc.dart';

abstract class TipEvent extends Equatable {
  const TipEvent();

  @override
  List<Object> get props => [];
}

class AmountPerPersonEvent extends TipEvent {
  final double total;
  final double quantity;

  const AmountPerPersonEvent(this.total, this.quantity);
}
