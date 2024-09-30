import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:tag_music/handlers/tag_audio_handler.dart';
import 'package:tag_music/providers/song_list_provider.dart';

class NewAudioPlayerProvider extends ChangeNotifier {
  // use the audio handler that we created
  late TagAudioHandler player;
  SongListProvider songListProvider = SongListProvider();

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  ConcatenatingAudioSource playlist = ConcatenatingAudioSource(children: []);

  NewAudioPlayerProvider() {
    initHandler();
  }

  void initHandler() async {
    player = await AudioService.init(
      builder: () => TagAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId:
            'com.audioplayer', //set the app bundle id for android
        androidNotificationChannelName:
            'Flutter Audio Player', //the name to show in the background player
        androidNotificationOngoing: true,
      ),
    );

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
      duration = d ?? Duration.zero;
      notifyListeners();
    });
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  Future<void> play() async {
    player.play();
    notifyListeners();
  }

  Future<void> pause() async {
    player.pause();
    notifyListeners();
  }

  Future<void> seek(double time) async {
    player.seek(Duration(seconds: time.toInt()));
    notifyListeners();
  }

  Future<void> seekToPrevious() async {
    player.skipToPrevious();
    notifyListeners();
  }

  Future<void> seekToNext() async {
    player.skipToNext();
    notifyListeners();
  }

  Future<void> handlePlayPause() async {
    player.handlePlayPause();
    notifyListeners();
  }
}
