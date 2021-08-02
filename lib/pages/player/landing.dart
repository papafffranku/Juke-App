import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lessgoo/models/TrackModel.dart';

class MusicPlayer extends StatefulWidget {
  final List<Track> playList;
  final int selectedIndex;
  const MusicPlayer(
      {Key? key, required this.playList, required this.selectedIndex})
      : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  //Music Controls
  bool playing = false;
  IconData playBtn = Icons.play_circle_filled;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  List<Track>? playList;
  int? currentIndex;
  List<IconData> _icons = [Icons.play_circle_filled, Icons.pause_circle_filled];

  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    currentIndex = widget.selectedIndex;
    playList = widget.playList;
    super.initState();
    advancedPlayer = AudioPlayer(playerId: 'finalPlayer');
    advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    advancedPlayer.setUrl(playList![currentIndex!].url);
  }

  Widget btnStart() {
    //isPlaying=bool;
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 65,
              color: Colors.white,
            )
          : Icon(
              _icons[1],
              size: 65,
              color: Colors.white,
            ),
      onPressed: () {
        if (isPlaying == false) {
          advancedPlayer.play(playList![currentIndex!].url);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget btnFav() {
    return IconButton(
        onPressed: () {},
        icon:
            Icon(Icons.favorite_border_rounded, size: 35, color: Colors.white));
  }

  Widget btnPrev() {
    return IconButton(
        onPressed: () {
          if (_position >= Duration(seconds: 3)) {
            advancedPlayer.stop();
            advancedPlayer.resume();
          } else {
            currentIndex = currentIndex! - 1;
            advancedPlayer.setUrl(playList![currentIndex!].url);
            advancedPlayer.play(playList![currentIndex!].url);
            isPlaying = false;
          }
        },
        icon: Icon(
          Icons.skip_previous_rounded,
          size: 45,
          color: Colors.white,
        ));
  }

  Widget btnNext() {
    return IconButton(
        onPressed: () {
          advancedPlayer.stop();
          advancedPlayer.release();
          setState(() {
            currentIndex = currentIndex! + 1;
            advancedPlayer.setUrl(playList![currentIndex!].url);
            advancedPlayer.play(playList![currentIndex!].url);
            isPlaying = false;
          });
        },
        icon: Icon(
          Icons.skip_next_rounded,
          size: 45,
          color: Colors.white,
        ));
  }

  Widget slider() //MusicSlider
  {
    return Slider.adaptive(
        activeColor: Colors.white,
        inactiveColor: Colors.grey[800],
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Container(
      //color: Colors.black,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            btnPrev(),
            btnStart(),
            btnNext(),
          ],
        ),
      ),
    );
  }

  void btnMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              color: Colors.grey[900],
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.favorite_rounded,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "Like",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.comment_rounded,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "Comment",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.share_rounded,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "Share",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.playlist_add,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "Add to Playlist",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.queue_music_rounded,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "Add to Queue",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person_rounded,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "View Artist",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.album_rounded,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "View Album",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.flag_rounded,
                      color: Colors.white54,
                    ),
                    dense: true,
                    title: Text(
                      "Report",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container // Background
                        (
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(playList![currentIndex!].imgUrl),
                        ),
                      ),
                      height: 350,
                      width: 350,
                    ),
                  ],
                ),
              ),
              Container(
                //height: sHeight,

                //color: Colors.blue,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: sWidth,
                      child: Row //BackButton
                          (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.keyboard_arrow_down_sharp,
                                color: Colors.white, size: 32),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.messenger_outline_rounded,
                                color: Colors.white, size: 28),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(top: (sHeight - 400)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: sWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 17.0),
                                        child: Text(
                                          playList![currentIndex!].title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.favorite_border_rounded,
                                              size: 30,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 17.0),
                                    child: Text(
                                      playList![currentIndex!].artist,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                        child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              SliderTheme // TrackSlider
                                  (
                                      data: SliderTheme.of(context).copyWith(
                                        trackShape:
                                            RoundedRectSliderTrackShape(),
                                        trackHeight: 2.0,
                                      ),
                                      child: slider()),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 24, right: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (_position.toString().split('.').first)
                                              .split(':')[1] +
                                          ':' +
                                          (_position
                                                  .toString()
                                                  .split('.')
                                                  .first)
                                              .split(':')[2],
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    Text(
                                      (_duration.toString().split('.').first)
                                              .split(':')[1] +
                                          ':' +
                                          (_duration
                                                  .toString()
                                                  .split('.')
                                                  .first)
                                              .split(':')[2],
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        loadAsset(),
                      ],
                    )),
                    SizedBox(height: 25),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  btnMenu();
                                },
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
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
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
                                    TextSpan(
                                        text:
                                            currentIndex == playList!.length - 1
                                                ? '-'
                                                : playList![currentIndex! + 1]
                                                    .title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ]))),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
