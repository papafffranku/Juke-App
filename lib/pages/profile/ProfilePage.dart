import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/models/TrackModel.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/profile/EditProfile.dart';
import 'package:lessgoo/pages/profile/ProfileLoading.dart';
import 'package:lessgoo/pages/profile/Settings.dart';
import 'package:lessgoo/pages/profile/trackwidget/bio.dart';
import 'package:lessgoo/pages/profile/trackwidget/collab.dart';
import 'package:lessgoo/pages/profile/trackwidget/featured_track.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfilePage extends StatefulWidget {
  final String searchID;

  const ProfilePage({Key? key, required this.searchID}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false;
  int followerCount = 0;
  int trackCount = 0;
  int followingCount = 0;
  Stream<DocumentSnapshot<Object?>>? userdeets;
  Stream<QuerySnapshot<Object?>>? songdeets;
  Stream<DocumentSnapshot<Object?>>? private;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool? isLoading;
  List<Track> tracks = [];

  @override
  void initState() {
    userdeets = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.searchID)
        .snapshots();
    songdeets = FirebaseFirestore.instance
        .collection('tracks')
        .doc(widget.searchID)
        .collection("publicSong")
        .limit(3)
        .snapshots();
    super.initState();
    getFollowers();
    getFollowing();
    checkIfFollowing();
    getTrackList();
  }

  getTrackList() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await tracksRef
        .doc(widget.searchID)
        .collection('publicSong')
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      isLoading = false;
      trackCount = snapshot.docs.length;
      print(trackCount);
      tracks = snapshot.docs.map((doc) => Track.fromDocument(doc)).toList();
      print(tracks);
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followersRef
        .doc(widget.searchID)
        .collection('userFollowing')
        .get();
    setState(() {
      followingCount = snapshot.docs.length;
    });
  }

  getFollowers() async {
    QuerySnapshot snapshot = await followersRef
        .doc(widget.searchID)
        .collection('userFollowers')
        .get();
    setState(() {
      followerCount = snapshot.docs.length;
    });
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.searchID)
        .collection('userFollowers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      isFollowing = doc.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return StreamBuilder<DocumentSnapshot>(
      stream: userdeets,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Welp! kill me");
        }
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: ColorfulSafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    FadeIn(
                        duration: Duration(milliseconds: 500),
                        child: userContent(screenwidth, data!, widget.searchID)
                    ),
                    FadeIn(
                        duration: Duration(milliseconds: 500),
                        child: customTab(data)
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return ProfileLoading();
      },
    );
  }

  Widget userContent(
      double screenwidth, DocumentSnapshot<Object?> data, String otherUserId) {
    bool isCurrentUser = FirebaseAuth.instance.currentUser!.uid == otherUserId;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            height: 450,
            width: screenwidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.black,
                // image: DecorationImage(
                //     fit: BoxFit.cover,
                //     image: NetworkImage(data['avatarUrl'])
                // )
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data['avatarUrl']),
              foregroundColor: Colors.black,
              backgroundColor: Colors.black,
            ),
          ),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 25,
                    color: Colors.white),
                IconButton(
                    onPressed: () {
                      isCurrentUser
                          ? pushNewScreen(context, screen: ProfileSettings())
                          : Container();
                    },
                    icon: isCurrentUser
                        ? Text('')
                        : Icon(Icons.more_vert_rounded),
                    iconSize: 25,
                    color: Colors.white),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 450),
          child: Container(
            width: screenwidth,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data['username'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Spacer(),
                      buildFollowButton(data)
                    ],
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Singer, Producer",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            followerCount.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "followers",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            followingCount.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "following",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //function to set a song as featured
  setFeatured(String s) {
    users.doc(widget.searchID).update({"featured": s});
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

  Widget customTab(var data) {
    CollectionReference song = FirebaseFirestore.instance
        .collection('tracks')
        .doc(widget.searchID)
        .collection('publicSong');

    return Padding(
        padding: const EdgeInsets.only(top: 600.0),
        child: DefaultTabController(
            length: 2,
            child: Column(children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Tracks',
                  ),
                  Tab(
                    text: 'About',
                  )
                ],
              ),
              Container(
                color: Theme.of(context).backgroundColor,
                height: 400,
                child: TabBarView(children: [
                  Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: song.doc(data['featured']).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> featuredData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          DateTime time =
                              (featuredData['timestamp'] as Timestamp).toDate();
                          String year = time.year.toString();
                          return Featured(featuredData['coverLink'],
                              featuredData['SongName'], data['username'], year);
                        }

                        return Text("loading");
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tracks',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700)),
                              Text('See All',
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ])),
                    SizedBox(height: 10),
                    trackList()
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Bio(data['bio'],),
                      SizedBox(
                        height: 20,
                      ),
                      //Collabs(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.facebook_rounded,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              )
            ])));
  }

  Widget userEdit(dynamic data) {
    return RawMaterialButton(
      onPressed: () {
        pushNewScreen(
          context,
          screen: EditProfile(
            data: data,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      elevation: 2.0,
      fillColor: Theme.of(context).accentColor,
      child: Icon(
        Icons.edit,
        size: 20,
        color: Colors.black,
      ),
      shape: CircleBorder(),
    );
  }

  Widget buildFollowButton(dynamic data) {
    if (widget.searchID == FirebaseAuth.instance.currentUser!.uid) {
      return userEdit(data);
    } else if (isFollowing) {
      return buildButton(text: "Following", function: handleUnfollowUser);
    } else if (!isFollowing) {
      return buildButton(text: "Follow", function: handleFollowUser);
    } else
      return SizedBox();
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });

    // remove follower
    followersRef
        .doc(widget.searchID)
        .collection('userFollowers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    followingRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userFollowing')
        .doc(widget.searchID)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    activityfeedRef
        .doc(widget.searchID)
        .collection('feedItems')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  // remove following

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    // Make user follow another profile by updating their followers collection
    followersRef
        .doc(widget.searchID)
        .collection('userFollowers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({});
    // Adding the other profile to user's following collection
    followingRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userFollowing')
        .doc(widget.searchID)
        .set({});

    activityfeedRef
        .doc(widget.searchID)
        .collection('feedItems')
        .doc(currentUserId)
        .set({
      "type": "follow",
      "userId": currentUserId,
      "trackId": 'noVal',
      'timestamp': Timestamp.now(),
      "mediaUrl": 'noVal'
    });
  }

  Widget buildButton({required String text, function}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        child: TextButton(
          onPressed: function,
          child: Container(
              height: 40,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: text == 'Following'
                    ? Theme.of(context).accentColor
                    : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
              )),
        ),
      ),
    );
  }
}
