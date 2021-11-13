import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<List<ActivityFeedItem>> getActivityFeed() async {
    try {
      QuerySnapshot snapshot = await activityfeedRef
          .doc(currentUserId)
          .collection('feedItems')
          .orderBy('timestamp', descending: true)
          .limit(50)
          .get();

      List<ActivityFeedItem> feedItems = [];

      snapshot.docs.forEach((doc) {
        feedItems.add(ActivityFeedItem.fromDocument(doc));
        print('Activity Feed Item: ${doc.data}');
      });
      print(feedItems);
      return feedItems;
    } catch (error) {
      print(error);
      return <ActivityFeedItem>[];
    }
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
              padding: EdgeInsets.all(15),
              child: routeHeader(title: 'Notifications'),
            ),
            Container(
              child: FutureBuilder(
                future: getActivityFeed(),
                builder:
                    (context, AsyncSnapshot<List<ActivityFeedItem>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  return ListView(shrinkWrap: true, children: snapshot.data!);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ActivityFeedItem extends StatelessWidget {
  String type;
  String userId;
  String trackId;
  Timestamp timestamp;

  ActivityFeedItem(
      {required this.timestamp,
      required this.trackId,
      required this.type,
      required this.userId});

  factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
    return ActivityFeedItem(
        timestamp: doc['timestamp'],
        trackId: doc['trackId'],
        type: doc['type'],
        userId: doc['userId']);
  }

  configureMediaPreview() {
    String? activityItemText;
    String? mediaUrl;
    var mediaPreview;
    print(activityItemText);

    if (trackId != "noVal") {}

    if (type == 'follow') {
      activityItemText = 'started following you';
    }
    if (type == 'like') {
      activityItemText = 'liked your post';
    }
    mediaPreview = [activityItemText.toString(), mediaUrl.toString()];

    return mediaPreview;
  }

  @override
  Widget build(BuildContext context) {
    List<String> mediaPreview = configureMediaPreview();
    return FutureBuilder<DocumentSnapshot>(
        future: userRef.doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                // color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(data['avatarUrl'])),
                  title: GestureDetector(
                    onTap: () {
                      pushNewScreen(context,
                          screen: ProfilePage(searchID: userId));
                    },
                    child: Text('${data['username']} ${mediaPreview[0]}'),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
