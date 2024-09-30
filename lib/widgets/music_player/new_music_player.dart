import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tag_music/providers/new_audio_player_provider.dart';

class NewMusicPlayer extends StatefulWidget {
  const NewMusicPlayer({super.key});

  @override
  State<NewMusicPlayer> createState() => _NewMusicPlayerState();
}

class _NewMusicPlayerState extends State<NewMusicPlayer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewAudioPlayerProvider>(builder: (context, audioplayer, _) {
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
              onChanged: audioplayer.seek,
            ),
            Text(audioplayer.formatDuration(audioplayer.duration)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.fast_rewind),
                    onPressed: audioplayer.seekToPrevious),
                IconButton(
                  icon: Icon(audioplayer.player.playing
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: audioplayer.handlePlayPause,
                ),
                IconButton(
                    icon: const Icon(Icons.fast_forward),
                    onPressed: audioplayer.seekToNext),
                // IconButton(
                //   icon: Icon(audioplayer.player.shuffleModeEnabled
                //       ? Icons.shuffle
                //       : Icons.arrow_right_alt),
                //   onPressed: audioplayer.handleShuffle,
                // ),
                // IconButton(
                //   icon: Icon(
                //     switch (audioplayer.player.loopMode) {
                //       LoopMode.off => Icons.close,
                //       LoopMode.one => Icons.repeat_one,
                //       LoopMode.all => Icons.repeat,
                //     }
                //     ),
                //   onPressed: audioplayer.handleLoopMode,
                // ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
