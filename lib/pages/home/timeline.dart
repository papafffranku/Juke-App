import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/models/TrackModel.dart';
import 'package:lessgoo/pages/home/home.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late List<Track> tracks;
  @override
  void initState() {
    getTimeline();
    super.initState();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .doc(currentUserId)
        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .get();

    int trackCount = snapshot.docs.length;
    print(trackCount);

    List<Track> tracks =
        snapshot.docs.map((doc) => Track.fromDocument(doc)).toList();
    print(tracks);

    setState(() {
      this.tracks = tracks;
    });
  }

  buildTimeline() {
    if (tracks == null) {
      return CircularProgressIndicator();
    } else if (tracks.isEmpty) {
      return Text('No Posts');
    } else {
      return Column(children: tracks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildTimeline();
  }
}
