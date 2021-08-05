import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Widget trails(String imgUrl, String trackName, String artistName) {
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imgUrl),
          )),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
            )),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText //Welcome Header
              (
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '$trackName',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  TextSpan(
                    text: '\n$artistName',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
    // ignore: unused_local_variable
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
                  backgroundColor: Colors.black87,
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
                                    pushNewScreen(context, screen: ProfilePage());
                                  }),
                            ],
                          ),
                          backgroundColor: Colors.black87,
                          pinned: true,
                          // onStretchTrigger: (){
                          //   return Future<void>.value();
                          //   },
                          actions: [
                            IconButton(
                                onPressed: () async {
                                  result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['mp3'],
                                  );
                                  file = result!.files.first;
                                  // ignore: non_constant_identifier_names
                                  final File UPF = File(file.path.toString());
                                  print(file.name);
                                  print(file.size);
                                  pushNewScreen(context,
                                      screen: SongUpload(UPFcon: UPF, uid: data['id'],));
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

                          expandedHeight: 175.0,
                          flexibleSpace: FlexibleSpaceBar(
                            stretchModes: const <StretchMode>[
                              StretchMode.blurBackground,
                            ],
                            background: Transform(
                              transform: Matrix4.translationValues(10.0, 50.0, 0.0),
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
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          'Dashboard',
                                          style: TextStyle(
                                              letterSpacing: 1.3,
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
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
                                                  color: Colors.black,
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
                                                              )),
                                                          TextSpan(
                                                              text: '  My Library',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w500)),
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
                                                  color: Colors.black,
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
                                                              )),
                                                          TextSpan(
                                                              text: '  Playlists',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w500)),
                                                        ],
                                                      ))),
                                            ),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          'New Releases',
                                          style: TextStyle(
                                              letterSpacing: 1.3,
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        height: 200,
                                        child: ListView //New Releases
                                          (
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            SizedBox(width: 10),
                                            trails(
                                                'https://upload.wikimedia.org/wikipedia/en/1/1b/Joji_-_Nectar.png',
                                                'Gimme Love',
                                                'Joji'),
                                            SizedBox(width: 10),
                                            trails(
                                                'https://upload.wikimedia.org/wikipedia/en/c/c1/The_Weeknd_-_After_Hours.png',
                                                'After Hours',
                                                'The Weeknd'),
                                            SizedBox(width: 10),
                                            trails(
                                                'https://upload.wikimedia.org/wikipedia/en/b/b8/Mura_Masa_album.jpg',
                                                'Mura Masa',
                                                'Mura Masa'),
                                            SizedBox(width: 10),
                                            trails(
                                                'https://images.genius.com/3e19af5cd67d794b62e6b0fe59de0cde.500x500x1.jpg',
                                                'Between Days',
                                                'Far Caspian')
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 15),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'Trails',
                                                style: TextStyle(
                                                    letterSpacing: 1.3,
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(height: 15),
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
                                            SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'New Releases',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  )),
                            ])),
                      ]),
                ));
          } else {
            return ProfileLoading();
          }
        });
  }
}