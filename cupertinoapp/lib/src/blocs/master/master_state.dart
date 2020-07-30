import 'package:meta/meta.dart' show required;
import 'package:equatable/equatable.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';

class MasterState extends Equatable {
  final int currentTab;
  final List<YouTubeVideo> history;
  final List<YouTubeVideo> favorites;

  MasterState(
      {@required this.currentTab, @required this.history, this.favorites});

  static MasterState initialState() =>
      MasterState(currentTab: 0, history: [], favorites: []);

  MasterState copyWith(
      {int currentTab,
      List<YouTubeVideo> history,
      List<YouTubeVideo> favorites}) {
    return MasterState(
        currentTab: currentTab ?? this.currentTab,
        history: history ?? this.history,
        favorites: favorites ?? this.favorites);
  }

  @override
  List<Object> get props => [currentTab, history, favorites];
}
