import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

import 'common.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer _player;
  bool _visible = true;
  final _playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(
      Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FLUMBERJACK%20(Audio).mp3?alt=media&token=20161301-fcf0-450f-82f4-a5b7bc129b61'),
      tag: MediaItem(
          id: '1',
          title: 'Tyler, The Creator',
          artist: 'Tyler',
          artUri: Uri.parse(
              'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/images%2FTyler-the-Creator-Lumberjack.jpeg?alt=media&token=c70c73f4-b04c-4ee4-bae8-5a1392b7ea54')),
    ),
  ]);
  int _addedCount = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _visible = !_visible;
      });
    });
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: StreamBuilder<SequenceState?>(
              stream: _player.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) return SizedBox();
                final metadata = state!.currentSource!.tag as MediaItem;
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(metadata.artUri.toString()))),
                  child: Container(
                    color: Theme.of(context).backgroundColor.withOpacity(0.5),
                    child: GlassContainer(
                      blur: 40,
                      opacity: 0.01,
                      border: Border.all(
                        color: Colors.white.withOpacity(0),
                      ),
                      borderRadius: BorderRadius.circular(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Row //BackButton
                                (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white, size: 36),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.message,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTapDown: (details) => _onTapDown(details),
                                child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                            metadata.artUri.toString()),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: AnimatedOpacity(
                                        opacity: _visible ? 1 : 0,
                                        duration: const Duration(seconds: 5),
                                        child: Row(
                                          // btn Controls
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: Container(
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    shape: BoxShape.circle),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'previous\n',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: Container(
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    shape: BoxShape.circle),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'next\n',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    height: 330,
                                    width: MediaQuery.of(context).size.width),
                              ),
                              SizedBox(height: 15),
                              ControlButtons(_player),
                              SizedBox(height: 15),
                              Center(
                                child: Text(
                                  metadata.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35),
                                ),
                              ),
                              SizedBox(height: 5),
                              Center(
                                child: Text(
                                  metadata.artist.toString(),
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),

                          //Play Button
                          Row(
                            children: [
                              StreamBuilder<PlayerState>(
                                stream: _player.playerStateStream,
                                builder: (context, snapshot) {
                                  final playerState = snapshot.data;
                                  final processingState =
                                      playerState?.processingState;
                                  final playing = playerState?.playing;
                                  if (processingState ==
                                          ProcessingState.loading ||
                                      processingState ==
                                          ProcessingState.buffering) {
                                    return Container(
                                      margin: EdgeInsets.all(8.0),
                                      width: 64.0,
                                      height: 64.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  } else if (playing != true) {
                                    return IconButton(
                                      icon: Icon(Icons.play_circle_filled),
                                      iconSize: 64.0,
                                      onPressed: _player.play,
                                    );
                                  } else if (processingState !=
                                      ProcessingState.completed) {
                                    return IconButton(
                                      icon: Icon(Icons.pause_circle_filled),
                                      iconSize: 64.0,
                                      onPressed: _player.pause,
                                    );
                                  } else {
                                    return IconButton(
                                      icon: Icon(Icons.replay),
                                      iconSize: 64.0,
                                      onPressed: () => _player.seek(
                                          Duration.zero,
                                          index:
                                              _player.effectiveIndices!.first),
                                    );
                                  }
                                },
                              ),
                              Expanded(
                                child: StreamBuilder<PositionData>(
                                  stream: _positionDataStream,
                                  builder: (context, snapshot) {
                                    final positionData = snapshot.data;
                                    return SeekBar(
                                      duration: positionData?.duration ??
                                          Duration.zero,
                                      position: positionData?.position ??
                                          Duration.zero,
                                      bufferedPosition:
                                          positionData?.bufferedPosition ??
                                              Duration.zero,
                                      onChangeEnd: (newPosition) {
                                        _player.seek(newPosition);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: Container(
                              //color: Colors.pink,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.more_horiz_rounded,
                                          size: 35,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      50.0),
                                            ),
                                            primary: Colors.grey[900])),
                                    SizedBox(height: 7.5),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        child: ListTile(
                                            leading: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.keyboard_arrow_up),
                                                iconSize: 32,
                                                color: Colors.white),
                                            title:
                                                Text.rich(TextSpan(children: [
                                              TextSpan(
                                                  text: 'Up Next : ',
                                                  style: TextStyle(
                                                      color: Colors.white54,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ]))))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double sWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < sWidth / 3) {
      _player.hasPrevious ? _player.seekToPrevious() : null;
    } else if (dx > 2 * sWidth / 3) {
      _player.hasNext ? _player.seekToNext() : null;
    }
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return Container(
      width: sWidth / 2,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder<LoopMode>(
            stream: player.loopModeStream,
            builder: (context, snapshot) {
              final loopMode = snapshot.data ?? LoopMode.off;
              var activeColor = Theme.of(context).accentColor;
              var icons = [
                Icon(Icons.repeat, color: Colors.grey),
                Icon(Icons.repeat, color: activeColor),
                Icon(Icons.repeat_one, color: activeColor),
              ];
              const cycleModes = [
                LoopMode.off,
                LoopMode.all,
                LoopMode.one,
              ];
              final index = cycleModes.indexOf(loopMode);
              return IconButton(
                icon: icons[index],
                onPressed: () {
                  player.setLoopMode(cycleModes[
                      (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
                },
              );
            },
          ),
          Icon(Icons.favorite_border_outlined),
          StreamBuilder<bool>(
            stream: player.shuffleModeEnabledStream,
            builder: (context, snapshot) {
              final shuffleModeEnabled = snapshot.data ?? false;
              return IconButton(
                icon: shuffleModeEnabled
                    ? Icon(Icons.shuffle, color: Theme.of(context).accentColor)
                    : Icon(Icons.shuffle, color: Colors.grey),
                onPressed: () async {
                  final enable = !shuffleModeEnabled;
                  if (enable) {
                    await player.shuffle();
                  }
                  await player.setShuffleModeEnabled(enable);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
