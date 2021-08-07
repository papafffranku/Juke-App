import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/models/TrailModel.dart';
import 'package:lessgoo/pages/library/library_landing.dart';
import 'package:lessgoo/pages/profile/ProfileLoading.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/pages/uploadsong/uploadscreens.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List<Trails> trailList = [
  Trails(
    artistName: 'Tame_Impala',
    imgUrl:
        'https://www.rollingstone.com/wp-content/uploads/2019/05/tame-impala-lead-photo.jpg',
  ),
  Trails(
    artistName: 'Kanye_West',
    imgUrl:
        'https://media.pitchfork.com/photos/60fabf372e77ffecd64d64ad/2:1/w_2560%2Cc_limit/Kanye-West.jpg',
  ),
  Trails(
    artistName: 'J.Cole',
    imgUrl: 'https://i.scdn.co/image/ab6761610000e5ebadd503b411a712e277895c8a',
  ),
  Trails(
    artistName: 'Brockhampton',
    imgUrl:
        'https://media.newyorker.com/photos/607de09d8f675fab920cd1f1/1:1/w_1920,h_1920,c_limit/Pearce-BrockhamptonPandemic.jpg',
  ),
  Trails(
    artistName: 'Tame_Impalalalala',
    imgUrl:
        'https://www.rollingstone.com/wp-content/uploads/2019/05/tame-impala-lead-photo.jpg',
  ),
  Trails(
    artistName: 'Tame_Impala',
    imgUrl:
        'https://www.rollingstone.com/wp-content/uploads/2019/05/tame-impala-lead-photo.jpg',
  ),
];

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FilePickerResult? result;
  late PlatformFile file;

  Widget playlister(String imgUrl, String playlistName, String playlistDesc) {
    return Column(
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imgUrl),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle),
              child: Icon(Icons.play_arrow_rounded,
                  size: 35, color: Theme.of(context).accentColor),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          child: Align(
            alignment: Alignment.topLeft,
            child: RichText //Welcome Header
                (
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: playlistName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  TextSpan(
                    text: '\n$playlistDesc',
                    style: TextStyle(
                        fontSize: 13, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget artistRelease(
      String imgUrl, String trackName, String artistName, String releaseType) {
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
                    text: '$releaseType',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).accentColor.withOpacity(0.9)),
                  ),
                  TextSpan(
                    text: '\n$trackName',
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

  Widget trailAvatar(String imgurl, String artistName) {
    return Column(
      children: [
        Stack(children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            radius: 5,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(imgurl),
            radius: 35,
          ),
        ]),
        SizedBox(height: 10),
        Container(
          width: 80,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    artistName.toLowerCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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

            return Scaffold(
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
                                  screen: SongUpload(
                                    UPFcon: UPF,
                                    uid: '',
                                  ));
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
                                  'dashboard',
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
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
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
                                            color: Colors.black,
                                            size: 20,
                                          )),
                                          TextSpan(
                                              text: '  My Library',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ))),
                                    ),
                                    onTap: () {
                                      pushNewScreen(context,
                                          screen: LibraryPage());
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: 170,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
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
                                            color: Colors.black,
                                            size: 20,
                                          )),
                                          TextSpan(
                                              text: '  Playlists',
                                              style: TextStyle(
                                                  color: Colors.black,
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
                                  'new releases',
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
                                    artistRelease(
                                        'https://upload.wikimedia.org/wikipedia/en/1/1b/Joji_-_Nectar.png',
                                        'Gimme Love',
                                        'Joji',
                                        'single'),
                                    SizedBox(width: 10),
                                    artistRelease(
                                        'https://upload.wikimedia.org/wikipedia/en/c/c1/The_Weeknd_-_After_Hours.png',
                                        'After Hours',
                                        'The Weeknd',
                                        'album'),
                                    SizedBox(width: 10),
                                    artistRelease(
                                        'https://upload.wikimedia.org/wikipedia/en/b/b8/Mura_Masa_album.jpg',
                                        'Mura Masa',
                                        'Mura Masa',
                                        'album'),
                                    SizedBox(width: 10),
                                    artistRelease(
                                        'https://images.genius.com/3e19af5cd67d794b62e6b0fe59de0cde.500x500x1.jpg',
                                        'Between Days',
                                        'Far Caspian',
                                        'single')
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
                                        'trails',
                                        style: TextStyle(
                                            letterSpacing: 1.3,
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                        height: 110,
                                        child: ListView.builder(
                                          itemCount: trailList.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Column(
                                                children: [
                                                  trailAvatar(
                                                      trailList[index].imgUrl,
                                                      trailList[index]
                                                          .artistName)
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
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'playlists for you',
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
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SizedBox(width: 15),
                                    playlister(
                                        'https://images.unsplash.com/photo-1483412033650-1015ddeb83d1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1053&q=80',
                                        'the weekly shuffle',
                                        'A customised playlist cherry picked just for you. Tune in, sit back and relax while you listen to the freshest beats in town.'),
                                    SizedBox(width: 15),
                                    playlister(
                                        'https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
                                        'randomizer',
                                        'Tired of the same old? Here is a breath of fresh air. You might find a few hidden gems in here too if you are lucky, hehe.'),
                                    SizedBox(width: 15),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ])),
                  ]),
            );
          } else {
            return ProfileLoading();
          }
        });
  }
}
