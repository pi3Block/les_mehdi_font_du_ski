import 'package:flame_audio/flame_audio.dart';

import '../game_state.dart';

///Wraper to play any audio and load the assets
class MehdiSkiGameAudioPlayer {
  ///Load all audio assets
  Future<void> loadAssets() async {
    //Sound from https://opengameart.org/content/atari-booms by dklon

    //Sound based on https://opengameart.org/content/rocket-launch-pack by dklon
    await FlameAudio.audioCache.loadAll(['atari_boom5.mp3', 'engine.mp3']);
  }

  ///Play the default explosion sound
  void playExplosion() {
    if (GameState.playSounds) {
      FlameAudio.play('atari_boom5.mp3');
    }
  }

  ///Play engine sound
  void playEngine() {
    if (GameState.playSounds) {
      FlameAudio.play('engine.mp3');
    }
  }
}