part of 'master_bloc.dart';

class MasterState extends Equatable {
  final int currentTab;

  MasterState({@required this.currentTab});

  static MasterState initialState() => MasterState(currentTab: 0);

  MasterState copyWith({int currentTab}) {
    return MasterState(currentTab: currentTab ?? this.currentTab);
  }

  @override
  List<Object> get props => [currentTab];
}
