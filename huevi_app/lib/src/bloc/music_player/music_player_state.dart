import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

enum MusicPlayerStatus { play, loading, pause, stop }

class MusicPlayerState extends Equatable {
  final MusicPlayerStatus status;

  MusicPlayerState({@required this.status});

  static MusicPlayerState get initialState =>
      MusicPlayerState(status: MusicPlayerStatus.play);

  MusicPlayerState copyWith({MusicPlayerStatus status}) {
    return MusicPlayerState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
