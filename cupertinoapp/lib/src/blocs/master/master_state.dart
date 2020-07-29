import 'package:meta/meta.dart' show required;
import 'package:equatable/equatable.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';

class MasterState extends Equatable {
  final int currentTab;
  final List<YouTubeVideo> history;

  MasterState({@required this.currentTab, @required this.history});

  static MasterState initialState() => MasterState(currentTab: 0, history: []);

  MasterState coyWith({int currentTab, List<YouTubeVideo> history}) {
    return MasterState(
        currentTab: currentTab ?? this.currentTab,
        history: history ?? this.history);
  }

  @override
  List<Object> get props => [currentTab, history];
}
