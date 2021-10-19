import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/widgets/routepageheader.dart';

class ActivityFeed extends StatefulWidget {
  const ActivityFeed({Key? key}) : super(key: key);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  getActivityFeed() async {
    QuerySnapshot snapshot = await activityfeedRef
        .doc(currentUserId)
        .collection("feedItems")
        .orderBy('timestamp', descending: true)
        .limit(50)
        .get();

    snapshot.docs.forEach((doc) {
      print('Activity Feed Item: ${doc.data()}');
    });
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: routePageAppBar(context: context, icon: null),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: routeHeader(title: 'Activity'),
          ),
          Container(
            child: FutureBuilder(
              future: getActivityFeed(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Text(
                  ' Gululu',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
