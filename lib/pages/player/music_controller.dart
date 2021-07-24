import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;

  const AudioFile({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final String path = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;

  List<IconData> _icons = [
    Icons.play_circle_filled,
    Icons.pause_circle_filled
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    this.widget.advancedPlayer.setUrl(path);
  }

  Widget btnStart() {
    //isPlaying=bool;
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying==false?Icon(_icons[0],size:65,color: Colors.white,):Icon(_icons[1],size:65,color: Colors.white,),
      onPressed: () {
        if(isPlaying==false) {
          this.widget.advancedPlayer.play(path);
          setState(() {
            isPlaying = true;
          });
        }
        else if(isPlaying==true){
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });
        }
    },
    );
  }

  Widget btnFav(){
    return IconButton(onPressed: (){},
        icon: Icon(Icons.favorite_border_rounded, size: 35, color: Colors.white));
  }

  Widget btnPrev(){
    return IconButton(onPressed: (){},
        icon: Icon(Icons.skip_previous_rounded, size: 45, color: Colors.white,)
    );
  }

  Widget btnNext(){
    return IconButton(onPressed: (){},
        icon: Icon(Icons.skip_next_rounded, size: 45, color: Colors.white,)
    );
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

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }


  Widget loadAsset() {
    return
      Container(
        //color: Colors.black,
        width: MediaQuery. of(context). size. width,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: btnPrev(),
              ),
              btnStart(),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: btnNext(),
              ),
            ],
          ),
        ),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        Column(
          children: [

            Container(
              child:
              Column(
                children: [
                  SliderTheme // TrackSlider
                    (data: SliderTheme.of(context).copyWith(
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 2.0,
                  ), child: slider()),

                  Padding(
                    padding: const EdgeInsets.only(left: 24,right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((_position.toString().split('.').first).split(':')[1]+':'+
                          (_position.toString().split('.').first).split(':')[2],
                          style: TextStyle(fontSize: 14, color: Colors.white),),
                        Text((_duration.toString().split('.').first).split(':')[1]+':'+
                            (_duration.toString().split('.').first).split(':')[2],
                          style: TextStyle(fontSize: 14, color: Colors.white),),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            loadAsset(),

          ],
        )

    );
  }
}
