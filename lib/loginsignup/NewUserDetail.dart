import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/home/tools/album_tile.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';
import 'package:lessgoo/pages/profile/EditProfile.dart';

import 'package:lessgoo/pages/profile/Settings.dart';
import 'package:lessgoo/pages/profile/trackwidget/bio.dart';
import 'package:lessgoo/pages/profile/trackwidget/collab.dart';
import 'package:lessgoo/pages/profile/trackwidget/featured_track.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NewDetail extends StatefulWidget {
  const NewDetail({Key? key}) : super(key: key);

  @override
  _NewDetailState createState() => _NewDetailState();
}

class _NewDetailState extends State<NewDetail> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    double screenwidth = MediaQuery.of(context).size.width;
    String Background =
        'https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    String Profile =
        'https://www.nicepng.com/png/detail/627-6278749_at-the-movies-elliot-alderson.png';
    String? username;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc('z7lN3RH3tlZqpEAtvQcNDchOyTI3').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          username = data['username'];

          return Scaffold(
            backgroundColor: Color(0xff0e0e15),
            body: ColorfulSafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: 475,
                      width: screenwidth,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(Background))),
                    ),
                    Container //Gradient
                        (
                      height: 475,
                      decoration: BoxDecoration(
                          color: Color(0xff0e0e15),
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Color(0xff0e0e15).withOpacity(0.2),
                                Color(0xff0e0e15),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  pushNewScreen(context,
                                      screen: ProfileSettings());
                                },
                                icon: Icon(Icons.settings),
                                iconSize: 30,
                                color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 300.0),
                      child: Container(
                        width: screenwidth,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  username!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                            Text(
                              "Singer, Producer",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 18),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "125",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Songs",
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "1,290",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "followers",
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "25M",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "following",
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  // onTap: () {
                                  //   pushNewScreen(
                                  //     context,
                                  //     screen: EditProfile(),
                                  //     withNavBar: true,
                                  //     pageTransitionAnimation:
                                  //         PageTransitionAnimation.slideUp,
                                  //   );
                                  // },
                                  child: Container(
                                    height: 25,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                        )),
                                    child: Center(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //profile background
                    Padding(
                      padding: const EdgeInsets.only(top: 475.0),
                      child: Container(
                        color: Color(0xff0e0e15),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Column(
                                        children: [],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Albums',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            Text('See All',
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400)),
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
                                    // Bio(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Collabs(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        // GestureDetector(
                                        //   onTap: () {},
                                        //   child: Icon(
                                        //     Entypo.instagram,
                                        //     size: 40,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: 40)
                                  ],
                                )), //details
                          ],
                        ),
                      ),
                    ), //main content
                  ],
                ),
              ),
            ),
          );
          // return Text("email: ${data['email']} ${data['id']}");
        }
        return Text("loading");
      },
    );
  }
}
