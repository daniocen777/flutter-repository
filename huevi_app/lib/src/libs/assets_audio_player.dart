import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';

class MusicPlayer {
  final assetsAudioPlayer = AssetsAudioPlayer();

  Future<void> dispose() async {
    await assetsAudioPlayer.dispose();
  }

  Future<void> play(String uri) async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(uri),
      );
    } catch (e) {
      print(' ************ ERROR ************ ==> $e');
    }
  }

  Future<void> playAsset(String path) async {
    try {
      await assetsAudioPlayer.open(
        Audio(path),
      );
    } catch (e) {
      print(' ************ ERROR ************ ==> $e');
    }
  }

  Future<void> pause() async {
    await assetsAudioPlayer.pause();
  }
}
