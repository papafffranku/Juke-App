import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lessgoo/pages/home/tools/album_tile.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';
import 'package:lessgoo/pages/profile/EditProfile.dart';
import 'package:lessgoo/pages/profile/ProfileLoading.dart';
import 'package:lessgoo/pages/profile/Settings.dart';
import 'package:lessgoo/pages/profile/trackwidget/bio.dart';
import 'package:lessgoo/pages/profile/trackwidget/collab.dart';
import 'package:lessgoo/pages/profile/trackwidget/featured_track.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String Background =
      'https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  Stream<DocumentSnapshot<Object?>>? userdeets;
  Stream<QuerySnapshot<Object?>>? songdeets;
  Stream<DocumentSnapshot<Object?>>? private;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    userdeets =
        FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
    songdeets = FirebaseFirestore.instance
        .collection('tracks')
        .doc(uid)
        .collection("publicSong")
        .limit(3)
        .snapshots();
    super.initState();
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
                    userContent(screenwidth, data!),
                    customTab(),
                    //main content
                    // StreamBuilder<QuerySnapshot>(
                    //     stream: songdeets,
                    //     builder:
                    //         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //       if (snapshot.hasError) {
                    //         return Text("Something went wrong");
                    //       }
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return Text("Loading");
                    //       } else {
                    //         var song = snapshot.data!.docs;
                    //         return mainContent(screenwidth, data, song);
                    //       }
                    //     })
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

  Widget userContent(double screenwidth, DocumentSnapshot<Object?> data) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            height: 265,
            width: screenwidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(data['avatarUrl']))),
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
                      pushNewScreen(context, screen: ProfileSettings());
                    },
                    icon: Icon(Icons.settings),
                    iconSize: 25,
                    color: Colors.white),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 300),
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
                      RawMaterialButton(
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: EditProfile(
                              data: data,
                            ),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideUp,
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.black,
                        ),
                        shape: CircleBorder(),
                      ),
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
                            data['followers'].toString(),
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
                            data['following'].toString(),
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

  Widget customTab() {
    return Padding(
        padding: const EdgeInsets.only(top: 460.0),
        child: DefaultTabController(
            length: 3,
            child: Column(children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Songs',
                  ),
                  Tab(
                    text: 'Albums',
                  ),
                  Tab(
                    text: 'About',
                  )
                ],
              ),
              Container(
                color: Colors.blue,
                height: 300,
                child: TabBarView(children: [
                  Text('1'),
                  Text('1'),
                  Text('1'),
                ]),
              )
            ])));
  }

  Widget mainContent(double screenwidth, DocumentSnapshot<Object?> data,
      List<QueryDocumentSnapshot<Object?>> song) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 510.0),
          child: Container(
            color: Colors.black,
            width: screenwidth,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Featured(
                            'https://img.discogs.com/UB8uZXucpxGcbdrtqoVZFHWZ2Cw=/fit-in/600x598/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-10268904-1494414512-7307.jpeg.jpg',
                            'Someone To Stay',
                            'Vikram Sharma',
                            '2021'),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Top Songs',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700)),
                              Text('See All',
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            height: ((song.length) * 150),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: song.length,
                              itemBuilder: (BuildContext context, int index) {
                                return trackTile(song[index]['SongName'],
                                    data['username'], song[index]['coverLink']);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Albums',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700)),
                                Text('See All',
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                              height: 200,
                              //width: 120,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  albumTile(
                                      'https://upload.wikimedia.org/wikipedia/en/1/1b/Joji_-_Nectar.png',
                                      'Nectar',
                                      '2021'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  albumTile(
                                      'https://daddykool.com/Photo/418464302795',
                                      'Circles',
                                      '2020'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  albumTile(
                                      'https://ichef.bbci.co.uk/news/976/cpsprodpb/61CC/production/_106763052_tdcc_cover-nc.jpg',
                                      'Two Door Cinema Club',
                                      '2019'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  albumTile(
                                      'https://vman.com/wp-content/uploads/sites/2/2019/10/699d9ba27c686b9e0f7858b6d778fb23.1000x1000x1.png',
                                      'Dusk',
                                      '2019'),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Bio(data['bio']),
                        SizedBox(
                          height: 20,
                        ),
                        Collabs(),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                        SizedBox(height: 100)
                      ],
                    )), //details
              ],
            ),
          ),
        ),
      ],
    );
  }
}
