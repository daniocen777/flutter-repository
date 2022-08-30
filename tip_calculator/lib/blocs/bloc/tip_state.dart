part of 'tip_bloc.dart';

@immutable
class TipState extends Equatable {
  final double amountPerPerson;

  const TipState({this.amountPerPerson = 10.0});

  TipState copyWith({double? amountPerPerson}) {
    return TipState(amountPerPerson: amountPerPerson ?? this.amountPerPerson);
  }

  @override
  List<Object> get props => [amountPerPerson];
}

class TipInitialState extends TipState {
  const TipInitialState() : super(amountPerPerson: 10.0);
}
