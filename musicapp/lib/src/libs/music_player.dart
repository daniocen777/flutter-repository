/* Usando paquete de: https://pub.dev/packages/flutter_sound/install */
import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';

/* import 'package:flutter_sound_lite/flutter_sound.dart'; */

class MusicPlayer {
  /* Completer<AssetsAudioPlayer> _completer = Completer(); */
  final assetsAudioPlayer = AssetsAudioPlayer();

  MusicPlayer() {
    this._init();
  }

  dispose() async {
    print('************ CERRANDO CLASE "MusicPlayer" ************');
    /* await (await this._completer.future).stop(); */
    /* await assetsAudioPlayer.stop(); */
    await assetsAudioPlayer.dispose();
  }

  Future<void> _init() async {
    /* final FlutterSoundPlayer player =
        await FlutterSoundPlayer().openAudioSession();
    this._completer.complete(player); */
  }

  Future<void> play(String uri) async {
    /* final FlutterSoundPlayer player = await this._completer.future;
    print('******* REPRODUCIENDO AUDIO *******');
    await player.startPlayer(fromURI: uri); */

    try {
      await assetsAudioPlayer.open(
        Audio.network(uri),
      );
    } catch (e) {
      print(' ************ ERROR ************ ==> $e');
    }
  }
}
