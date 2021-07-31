import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';
import 'package:lessgoo/pages/profile/ProfileLoading.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/pages/uploadsong/uploadscreens.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FilePickerResult? result;
  late PlatformFile file;

  Container trails(String imgUrl) {
    return Container(
        width: 100,
        child: Card(child: Wrap(children: <Widget>[Image.network(imgUrl)])));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    double screenwidth = MediaQuery.of(context).size.width;

    double sWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return HomePage();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data?.data() as Map<String, dynamic>;

            return SafeArea(
                child: Scaffold(
                    backgroundColor: Color(0xff0e0e15),
                    body: CustomScrollView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        slivers: <Widget>[
                          SliverAppBar //QuickAccess Bar
                              (
                            automaticallyImplyLeading: false,
                            leading: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage:
                                      NetworkImage(data['avatarUrl']),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    onTap: () {
                                      pushNewScreen(context,
                                          screen: ProfilePage());
                                    }),
                              ],
                            ),
                            backgroundColor: Color(0xff0e0e15),
                            pinned: true,
                            // onStretchTrigger: (){
                            //   return Future<void>.value();
                            //   },
                            actions: [
                              IconButton(
                                  onPressed: () async {
                                    result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                      // allowedExtensions: ['mp3'],
                                    );
                                    file = result!.files.first;
                                    final File UPF = File(file.path.toString());
                                    print(file.name);
                                    print(file.size);
                                    pushNewScreen(context,
                                        screen: SongUpload(UPFcon: UPF));
                                    // Navigator.pushNamed(context, '/UploadSong',
                                    //     arguments: {
                                    //       'UPF': UPF,
                                    //     });
                                  },
                                  icon: Icon(Icons.add_circle_outline_rounded)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.notifications_none_rounded)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.message_outlined)),
                            ],

                            expandedHeight: 170.0,
                            flexibleSpace: FlexibleSpaceBar(
                              stretchModes: const <StretchMode>[
                                StretchMode.blurBackground,
                              ],
                              background: Transform(
                                transform:
                                    Matrix4.translationValues(10.0, 50.0, 0.0),
                                child: RichText //Welcome Header
                                    (
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '\nWelcome,',
                                        style: TextStyle(
                                            letterSpacing: 1.3,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 40),
                                      ),
                                      TextSpan(
                                        text: '\n${data['username']}',
                                        style: TextStyle(
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 40),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate([
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsets.only(left: sWidth / 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        'Dashboard',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            child: Container(
                                              width: 170,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff2c2c36),
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 17),
                                                      blurRadius: 17,
                                                      spreadRadius: -23,
                                                    )
                                                  ]),
                                              child: Center(
                                                  child: RichText(
                                                      text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                    Icons.library_music_rounded,
                                                    size: 20,
                                                    color: Colors.white,
                                                  )),
                                                  TextSpan(
                                                      text: '  My Library',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ))),
                                            ),
                                            onTap: () {},
                                          ),
                                          InkWell(
                                            child: Container(
                                              width: 170,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff2c2c36),
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 17),
                                                      blurRadius: 17,
                                                      spreadRadius: -23,
                                                    )
                                                  ]),
                                              child: Center(
                                                  child: RichText(
                                                      text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                    Icons.playlist_play_rounded,
                                                    size: 20,
                                                    color: Colors.white,
                                                  )),
                                                  TextSpan(
                                                      text: '  Playlists',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ))),
                                            ),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                      Text(
                                        'Trails',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 10),
                                      Container //Stories
                                          (
                                              height: 160,
                                              //width: 120,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: <Widget>[
                                                  trails(
                                                      'https://images.unsplash.com/photo-1614483573015-fc4ceb584797?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2002&q=80'),
                                                  trails(
                                                      'https://images.unsplash.com/photo-1614483573015-fc4ceb584797?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2002&q=80'),
                                                  trails(
                                                      'https://images.unsplash.com/photo-1614483573015-fc4ceb584797?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2002&q=80'),
                                                  trails(
                                                      'https://images.unsplash.com/photo-1614483573015-fc4ceb584797?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2002&q=80'),
                                                  trails(
                                                      'https://images.unsplash.com/photo-1614483573015-fc4ceb584797?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2002&q=80'),
                                                  trails(
                                                      'https://images.unsplash.com/photo-1614483573015-fc4ceb584797?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2002&q=80'),
                                                  trails(
                                                      'https://images.unsplash.com/photo-1614483573015-fc4ceb584797?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2002&q=80'),
                                                ],
                                              )),
                                      SizedBox(height: 25),
                                      Text(
                                        'Artists For You',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 120,
                                          child: ListView.builder(
                                            itemCount: 6,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoacSNemF4Ur3E4y2-iM7ntxSVOy3ECqvBHQ&usqp=CAU'),
                                                      radius: 40,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'Mithul',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          )),
                                      SizedBox(height: 25),
                                      Text(
                                        'New Releases',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 10),
                                      Container //DisplayTracks
                                          (
                                        width: double.infinity,
                                        height: 300,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            trackTile('Blood', 'On', 23,
                                                'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png'),
                                            trackTile('Blood', 'On', 23,
                                                'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png'),
                                            trackTile('Blood', 'On', 23,
                                                'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png'),
                                            trackTile('Blood', 'On', 23,
                                                'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                )),
                          ]))
                        ])));
          }
          else{
            return ProfileLoading();
          }
        });
  }
}
