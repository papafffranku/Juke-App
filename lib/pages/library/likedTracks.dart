import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/models/TrackModel.dart';
import 'package:lessgoo/pages/home/home.dart';

class LikedTracks extends StatefulWidget {
  const LikedTracks({Key? key}) : super(key: key);

  @override
  _LikedTracksState createState() => _LikedTracksState();
}

class _LikedTracksState extends State<LikedTracks> {
  bool? isLoading;
  List<Track> tracks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrackList();
  }

  getTrackList() async {
    setState(() {
      isLoading = true;
    });
    print('11');
    QuerySnapshot snapshot = await libraryRef
        .doc(currentUserId)
        .collection('likedTracks')
        .orderBy('timestamp', descending: true)
        .get();

    print('hi $snapshot');
    setState(() {
      print('22');
      isLoading = false;
      tracks = snapshot.docs.map((doc) => Track.fromDocument(doc)).toList();
      print(tracks);
    });
  }

  trackList() {
    if (isLoading!) {
      return CircularProgressIndicator();
    } else if (tracks.isEmpty) {
      print(tracks);
      return Text('No tracks');
    }
    return Container(child: Column(children: tracks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [trackList()],
        ),
      ),
    );
  }
}
