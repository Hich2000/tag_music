import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:tag_music/providers/song_list_provider.dart';

class AudioPlayerProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  SongListProvider songListProvider = SongListProvider();

  ConcatenatingAudioSource playlist =
        ConcatenatingAudioSource(children: []);

  AudioPlayerProvider() {
    for (var song in songListProvider.songs) {
      playlist.add(AudioSource.file(song,
          tag: MediaItem(id: song, title: basename(song))));
    }
    player.setAudioSource(playlist);
    player.setLoopMode(LoopMode.all);

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

  void playSong(int index) async {
    await player.stop();
    await player.setAudioSource(playlist, initialIndex: index);
    await player.play();
    notifyListeners();
  }

  void seekToNext() async {
    await player.seekToNext();
  }

  void seekToPrevious() async {
    await player.seekToPrevious();
  }

  void handleShuffle() async {
    if (player.shuffleModeEnabled) {
      await player.setShuffleModeEnabled(false);
    } else {
      await player.setShuffleModeEnabled(true);
    }
    notifyListeners();
  }

  void handleLoopMode() async {
    if (player.loopMode == LoopMode.off) {
      player.setLoopMode(LoopMode.all);
    } else if (player.loopMode == LoopMode.all) {
      player.setLoopMode(LoopMode.one);
    } else if (player.loopMode == LoopMode.one) {
      player.setLoopMode(LoopMode.off);
    }
    notifyListeners();
  }
}
