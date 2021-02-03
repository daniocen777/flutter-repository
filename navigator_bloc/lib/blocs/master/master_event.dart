part of 'master_bloc.dart';

class MasterEvent {}

class MasterSetTab extends MasterEvent {
  final int tab;

  MasterSetTab({this.tab});
}
