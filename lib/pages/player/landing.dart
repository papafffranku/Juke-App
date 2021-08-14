import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
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
  bool _visible = true;

  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _visible = !_visible;
      });
    });

    currentIndex = widget.selectedIndex;
    playList = widget.playList;
    super.initState();
    advancedPlayer = AudioPlayer(playerId: 'finalPlayer');
    trackSetter();

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
  }

  void trackComplete() {
    if (_position == _duration) {
      btnNext();
    }
    advancedPlayer.onPlayerCompletion.listen((event) {
      btnNext();
    });
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

  Future<void> trackSetter() async {
    await advancedPlayer.setUrl(playList![currentIndex!].url);
  }

  void btnPrev() {
    advancedPlayer.stop();
    advancedPlayer.release();
    currentIndex = currentIndex! - 1;
    trackSetter();
    advancedPlayer.play(playList![currentIndex!].url);
    isPlaying = false;
  }

  void btnNext() {
    if (currentIndex! + 1 < playList!.length) {
      advancedPlayer.stop();
      advancedPlayer.release();
      currentIndex = currentIndex! + 1;
      trackSetter();
      advancedPlayer.play(playList![currentIndex!].url);
      isPlaying = false;
    }
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
            //btnPrev(),
            btnStart(),
            //btnNext(),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    double sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(playList![currentIndex!].imgUrl))),
          child: GlassContainer(
            blur: 40,
            opacity: 0.01,
            border: Border.all(
              color: Colors.white.withOpacity(0),
            ),
            borderRadius: BorderRadius.circular(0),
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
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
                      icon: Icon(Icons.message, color: Colors.white, size: 32),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTapDown: (details) => _onTapDown(details),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(playList![currentIndex!].imgUrl),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: AnimatedOpacity(
                        opacity: _visible ? 1 : 0,
                        duration: const Duration(seconds: 5),
                        child: Row(
                          // btn Controls
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    shape: BoxShape.circle),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.skip_previous, size: 50),
                                    Text(
                                      'previous',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    shape: BoxShape.circle),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.skip_next, size: 50),
                                    Text(
                                      'next',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: sWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Center(
                          child: Container(
                            width: sWidth / 2,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .backgroundColor
                                    .withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.playlist_add_sharp,
                                        size: 26)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_border_rounded,
                                        size: 26)),
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        Icon(Icons.shuffle_rounded, size: 26)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.repeat, size: 26)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                            playList![currentIndex!].title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 35),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            playList![currentIndex!].artist,
                            style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.w300,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: btnStart(),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: SliderTheme // TrackSlider
                          (
                              data: SliderTheme.of(context).copyWith(
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 5.0,
                              ),
                              child: slider()),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (_position.toString().split('.').first).split(':')[1] +
                          ':' +
                          (_position.toString().split('.').first).split(':')[2],
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(' / '),
                    Text(
                      (_duration.toString().split('.').first).split(':')[1] +
                          ':' +
                          (_duration.toString().split('.').first).split(':')[2],
                      style: TextStyle(fontSize: 16, color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //color: Colors.pink,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                                primary: Colors.grey[900])),
                        SizedBox(height: 7.5),
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
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
                                  TextSpan(
                                      text: currentIndex == playList!.length - 1
                                          ? '-'
                                          : playList![currentIndex! + 1].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ]))))
                      ]),
                ),
              )
            ]),
          ),
        )));
  }

  void _onTapDown(TapDownDetails details) {
    final double sWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < sWidth / 3) {
      setState(() {
        btnPrev();
      });
    } else if (dx > 2 * sWidth / 3) {
      setState(() {
        btnNext();
      });
    }
  }
}
