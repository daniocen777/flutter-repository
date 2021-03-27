import 'package:equatable/equatable.dart';

class ContacrEntity extends Equatable {
  final String? uid;
  final String? phoneNumber;
  final String? label;
  final String? status;

  ContacrEntity({this.uid, this.phoneNumber, this.label, this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [uid, phoneNumber, label, status];
}
