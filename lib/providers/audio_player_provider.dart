import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path/path.dart';

class AudioPlayerProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  AudioPlayerProvider() {
    player.setAudioSource(AudioSource.file(
      "/storage/emulated/0/Music/1992.mp3",
      tag: const MediaItem(id: "1992", title: "1992.mp3")
      ));


    player.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });

    player.durationStream.listen((d) {
      duration = d!;
      notifyListeners();
    });
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double time) {
    player.seek(Duration(seconds: time.toInt()));
  }

  void playSong(String filePath) async {
    await player.stop();
    await player.setAudioSource(
      AudioSource.file(filePath,
      tag: MediaItem(id: basename(filePath), title: basename(filePath))
      )
      );
    await player.play();
    notifyListeners();
  }

}