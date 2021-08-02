import 'package:flutter/material.dart';
import 'package:lessgoo/models/TrackModel.dart';
import 'package:lessgoo/pages/player/landing.dart';

List<Track> audiolist = [
  Track(
      title: 'Lumberjack',
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/images%2FTyler-the-Creator-Lumberjack.jpeg?alt=media&token=c70c73f4-b04c-4ee4-bae8-5a1392b7ea54',
      artist: 'Tyler The Creator',
      url:
          'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FLUMBERJACK%20(Audio).mp3?alt=media&token=20161301-fcf0-450f-82f4-a5b7bc129b61',
      playing: false),
  Track(
      title: 'Bankroll',
      artist: 'Brockhampton',
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/images%2Fartworks-gmqyr0gCcIYPh9gw-ubKAIA-t500x500.jpg?alt=media&token=2b8c8ca9-8ee0-4cdc-a3d3-367118324ea2',
      url:
          'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FBANKROLL%20FEAT.%20A%24AP%20ROCKY%20%26%20A%24AP%20FERG%20-%20BROCKHAMPTON.mp3?alt=media&token=4501bea5-2b89-44be-97ca-9ee3fbed557e',
      playing: false),
  Track(
      title: 'Love Again',
      artist: 'Meltt',
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/images%2F400x400cc.jpeg?alt=media&token=b0b7881c-c186-44ff-832b-4eecbdcff92e',
      url:
          'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FMeltt%20-%20Love%20Again.mp3?alt=media&token=6b12bb82-cd7c-4a5a-bad0-9dc2abf32dcf',
      playing: false)
];

class PlaylistTester extends StatefulWidget {
  const PlaylistTester({Key? key}) : super(key: key);

  @override
  _PlaylistTesterState createState() => _PlaylistTesterState();
}

class _PlaylistTesterState extends State<PlaylistTester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: audiolist.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                audiolist[index].playing = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MusicPlayer(
                            playList: audiolist, selectedIndex: index)));
              },
              child: ListTile(
                leading: Icon(Icons.music_note_outlined),
                title: Text(audiolist[index].title),
                subtitle: Text(audiolist[index].artist),
                trailing: audiolist[index].playing == false
                    ? Icon(Icons.play_arrow)
                    : Icon(Icons.pause),
              ),
            );
          }),
    );
  }
}
