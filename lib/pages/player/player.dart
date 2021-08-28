import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'common.dart';

class Player extends StatefulWidget {
  final AudioPlayer player;
  final ConcatenatingAudioSource? playlist;
  const Player({Key? key, required this.player, required this.playlist})
      : super(key: key);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  int _addedCount = 0;
  late AudioPlayer _player;
  late ConcatenatingAudioSource _playlist;

  @override
  void initState() {
    super.initState();
    this._player = widget.player;
    if (widget.playlist != null) {
      this._playlist = widget.playlist!;
    }

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
      body: StreamBuilder<SequenceState?>(
          stream: _player.sequenceStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            final metadata = state!.currentSource!.tag as MediaItem;
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.complex.com/complex/image/upload/c_fill,dpr_auto,f_auto,fl_lossy,g_face,q_auto,w_1280/m7ll2zgzoxostwcoswzi.png'))),
              child: Container(
                color: Theme.of(context).backgroundColor.withOpacity(0.8),
                child: GlassContainer(
                  blur: 10,
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
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 35, bottom: 15),
                        child: Row //BackButton
                            (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white, size: 36),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  metadata.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  metadata.artist.toString(),
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                              ]),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTapDown: (details) => _onTapDown(details),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                        'https://images.complex.com/complex/image/upload/c_fill,dpr_auto,f_auto,fl_lossy,g_face,q_auto,w_1280/m7ll2zgzoxostwcoswzi.png'),
                                  ),
                                ),
                                height: 330,
                                width: 330),
                          ),
                          SizedBox(height: 15),
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
                              if (processingState == ProcessingState.loading ||
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
                                  onPressed: () => _player.seek(Duration.zero,
                                      index: _player.effectiveIndices!.first),
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
                                  duration:
                                      positionData?.duration ?? Duration.zero,
                                  position:
                                      positionData?.position ?? Duration.zero,
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
                      SizedBox(height: 15),
                      ControlButtons(_player),
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
                                              new BorderRadius.circular(50.0),
                                        ),
                                        primary: Colors.grey[900])),
                                SizedBox(height: 7.5),
                                Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: ListTile(
                                        leading: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.keyboard_arrow_up),
                                            iconSize: 32,
                                            color: Colors.white),
                                        title: Text.rich(TextSpan(children: [
                                          TextSpan(
                                              text: 'Up Next : ',
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w500)),
                                        ]))))
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          SizedBox(width: 5),
          Icon(Icons.chat_bubble_outline),
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
