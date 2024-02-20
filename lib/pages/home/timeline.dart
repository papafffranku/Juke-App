import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/models/TrackModel.dart';
import 'package:lessgoo/models/TrackModelRelease.dart';
import 'package:lessgoo/pages/home/home.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<TrackTimeline>? tracks;

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

    List<TrackTimeline> tracks =
        snapshot.docs.map((doc) => TrackTimeline.fromDocument(doc)).toList();
    print(tracks);

    setState(() {
      this.tracks = tracks;
    });
  }

  Widget nopost() {
    return FadeIn(
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Follow people to view their posts',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Head over to the ',
                    style: TextStyle(color: Colors.white),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      CupertinoIcons.infinite,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  TextSpan(
                    text: ' page',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  TextSpan(
                    text: ' to meet some new people ',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'or to the ',
                    style: TextStyle(color: Colors.white),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      CupertinoIcons.search,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  TextSpan(
                    text: ' page',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  TextSpan(
                    text: ' to find people via their username',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'Invite your friends',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(
            'Help us grow our community!',
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            label: Text("Share"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      )),
    );
  }

  Widget Success() {
    return FlareActor(
      'lib/assets/tickAnimation.flr',
      animation: 'Untitled',
      fit: BoxFit.contain,
    );
  }

  buildTimeline() {
    if (tracks == null) {
      return CircularProgressIndicator();
    } else if (tracks!.isEmpty) {
      return nopost();
    } else {
      return Column(children: tracks!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: buildTimeline(), onRefresh: () => getTimeline());
  }
}
