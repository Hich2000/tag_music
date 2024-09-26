import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tag_music/providers/audio_player_provider.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  @override
  Widget build(BuildContext context) {

    return Consumer<AudioPlayerProvider>(builder: (context, audioplayer, _) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(audioplayer.formatDuration(audioplayer.position)),
            Slider(
              min: 0.0,
              max: audioplayer.duration.inSeconds.toDouble(),
              value: audioplayer.position.inSeconds.toDouble(),
              onChanged: audioplayer.handleSeek,
            ),
            Text(audioplayer.formatDuration(audioplayer.duration)),
            IconButton(
              icon: Icon(audioplayer.player.playing ? Icons.pause : Icons.play_arrow),
              onPressed: audioplayer.handlePlayPause,
            )
          ],
        ),
      );
    });
  }
}
