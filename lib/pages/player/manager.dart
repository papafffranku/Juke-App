import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lessgoo/models/TrackModel.dart';

import 'package:lessgoo/pages/player/notifier/play_button_modifier.dart';
import 'package:lessgoo/pages/player/notifier/progress_notifier.dart';
import 'package:lessgoo/pages/player/notifier/repeat_button_notifier.dart';

class PageManager {
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  PageManager() {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    _setInitialPlaylist();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }

  void _setInitialPlaylist() async {
    final song1 = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FLUMBERJACK%20(Audio).mp3?alt=media&token=20161301-fcf0-450f-82f4-a5b7bc129b61');
    final song2 = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FBANKROLL%20FEAT.%20A%24AP%20ROCKY%20%26%20A%24AP%20FERG%20-%20BROCKHAMPTON.mp3?alt=media&token=4501bea5-2b89-44be-97ca-9ee3fbed557e');
    final song3 = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FMeltt%20-%20Love%20Again.mp3?alt=media&token=6b12bb82-cd7c-4a5a-bad0-9dc2abf32dcf');
    _playlist = ConcatenatingAudioSource(children: [
      AudioSource.uri(song1,
          tag: AudioMetadata(
              artist: 'Tyler The Creator',
              title: 'Lumberjack',
              artwork:
                  'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/images%2FTyler-the-Creator-Lumberjack.jpeg?alt=media&token=c70c73f4-b04c-4ee4-bae8-5a1392b7ea54')),
      AudioSource.uri(song2,
          tag: AudioMetadata(
              artist: 'Brockhampton',
              title: 'Bankroll',
              artwork:
                  'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/images%2Fartworks-gmqyr0gCcIYPh9gw-ubKAIA-t500x500.jpg?alt=media&token=2b8c8ca9-8ee0-4cdc-a3d3-367118324ea2')),
      AudioSource.uri(song3, tag: 'Song 3'),
    ]);
    await _audioPlayer.setAudioSource(_playlist);
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _listenForChangesInSequenceState() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      // update current song title
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String;
      currentSongTitleNotifier.value = title ?? '';

      // update playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      // update shuffle mode
      isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;

      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  void play() async {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  void onPreviousSongButtonPressed() {
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seekToNext();
  }

  void onShuffleButtonPressed() async {
    final enable = !_audioPlayer.shuffleModeEnabled;
    if (enable) {
      await _audioPlayer.shuffle();
    }
    await _audioPlayer.setShuffleModeEnabled(enable);
  }

  void addSong() {
    final songNumber = _playlist.length + 1;
    const prefix = 'https://www.soundhelix.com/examples/mp3';
    final song = Uri.parse('$prefix/SoundHelix-Song-$songNumber.mp3');
    _playlist.add(AudioSource.uri(song, tag: 'Song $songNumber'));
  }

  void removeSong() {
    final index = _playlist.length - 1;
    if (index < 0) return;
    _playlist.removeAt(index);
  }
}

class AudioMetadata {
  final String artist;
  final String title;
  final String artwork;

  AudioMetadata({
    required this.artist,
    required this.title,
    required this.artwork,
  });
}
