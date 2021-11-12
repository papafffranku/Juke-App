import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/pages/widgets/routepageheader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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

    List<ActivityFeedItem> feedItems = [];
    snapshot.docs.forEach((doc) {
      feedItems.add(ActivityFeedItem.fromDocument(doc));
    });
    return feedItems;
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
                return Text('$snapshot.data');

                // return ListView(children: snapshot.data);
              },
            ),
          )
        ],
      )),
    );
  }
}

String? activityItem;

class ActivityFeedItem extends StatelessWidget {
  final String userId;
  final String type; //activity type
  final String trackId;
  final Timestamp timestamp;

  ActivityFeedItem(
      {required this.userId,
      required this.type,
      required this.trackId,
      required this.timestamp});

  factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
    return ActivityFeedItem(
        userId: doc['userId'],
        type: doc['type'],
        trackId: doc['trackId'],
        timestamp: doc['timestamp']);
  }

  configureMediaPreview() {
    if (type == 'like') {
      activityItem = "liked your track";
    }
    if (type == 'follow') {
      activityItem = "started following you";
    } else {
      activityItem = "Unknown error '$type'";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Container(
          child: ListTile(
            title: GestureDetector(
              onTap: () =>
                  pushNewScreen(context, screen: ProfilePage(searchID: userId)),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                    children: [
                      TextSpan(
                        text: userId,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: activityItem)
                    ]),
              ),
            ),
          ),
        ));
  }
}
