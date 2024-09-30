import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class TagAudioHandler extends BaseAudioHandler with QueueHandler {
  // create the just audio object and source for play list
  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);
  Stream<Duration> positionStream = const Stream.empty();
  Stream<Duration?> durationStream = const Stream.empty();

  bool playing = false;

  TagAudioHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _loadEmptyPlaylist();

    positionStream = _player.positionStream;
    durationStream = _player.durationStream;

    _player.playingStream.listen((p) {
      playing = p;
    });
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      // setup and allow which control item in the control panel in the phone's lock screen
      controls: [
        MediaControl.skipToPrevious,
        // MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        // MediaControl.stop,
        // MediaControl.fastForward,
        MediaControl.skipToNext,
      ],
      // setup the action can be used, it will show the buttons in the phone's lock screen
      systemActions:  {
        MediaAction.skipToPrevious,
        if (_player.playing) MediaAction.pause else MediaAction.play,
        // MediaAction.seek,
        // MediaAction.seekForward,
        // MediaAction.seekBackward,
        MediaAction.skipToNext,
      },
      // for android lock screen control buttons
      androidCompactActionIndices: const [0, 1, 2],
      // map the audio service processing state to just audio
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing, // is playing status
      updatePosition: _player.position, // the current playing position
      bufferedPosition: _player.bufferedPosition, // the buffered position
      speed: _player.speed, // player speed
      queueIndex: event.currentIndex, // the index of the current queue
    );
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  Future<void> handlePlayPause() async {
    if (_player.playing) {
      pause();
    } else {
      play();
    }
  }

  Future<void> setAudioSource(ConcatenatingAudioSource playlist) async {
    _player.setAudioSource(playlist);
  }

  Future<void> setLoopMode(LoopMode loopMode) async {
    _player.setLoopMode(loopMode);
  }
}

