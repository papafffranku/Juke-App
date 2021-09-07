import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/models/TrailModel.dart';
import 'package:lessgoo/pages/home/page_routes/release_feed.dart';
import 'package:lessgoo/pages/home/page_routes/trail_view.dart';
import 'package:lessgoo/pages/library/library_landing.dart';
import 'package:lessgoo/pages/player/player.dart';
import 'package:lessgoo/pages/playlist/view_playlist.dart';
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
  final AudioPlayer homePlayer;

  State<HomePage> createState() => _HomePageState();
  const HomePage({Key? key, required this.homePlayer}) : super(key: key);
}

class _HomePageState extends State<HomePage> {
  FilePickerResult? result;
  late PlatformFile file;
  Stream<DocumentSnapshot<Object?>>? docStream;

  Widget playlister(String imgUrl, String playlistName, String playlistDesc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(imgUrl),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 150,
          child: RichText //Welcome Header
              (
            overflow: TextOverflow.ellipsis,
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
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget artistRelease(
      String imgUrl, String trackName, String artistName, String releaseType) {
    return Container(
      height: 180,
      width: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            fit: BoxFit.contain,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextSpan(
                    text: '\n$artistName',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white54),
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
            radius: 4,
          ),
          GestureDetector(
            onTap: () => pushNewScreen(context, screen: StoryPageView()),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imgurl),
              radius: 32,
            ),
          ),
        ]),
        SizedBox(height: 5),
        Container(
          width: 60,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    artistName.toLowerCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    docStream =
        FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    ConcatenatingAudioSource _playlist;
    AudioPlayer _player = widget.homePlayer;

    return StreamBuilder<DocumentSnapshot>(
        stream: docStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return HomePage(homePlayer: _player);
          }
          if (snapshot.hasData) {
            var data = snapshot.data;

            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Theme.of(context).accentColor,
              body: ColorfulSafeArea(
                color: Theme.of(context).accentColor,
                child: CustomScrollView(
                    physics: ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: <Widget>[
                      SliverAppBar //QuickAccess Bar
                          (
                        automaticallyImplyLeading: false,
                        leading: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 15),
                            InkWell(
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                      data!['avatarUrl']), //data!['avatarUrl']
                                ),
                                onTap: () {
                                  pushNewScreen(context, screen: ProfilePage());
                                }),
                          ],
                        ),
                        backgroundColor: Theme.of(context).accentColor,
                        pinned: true,
                        onStretchTrigger: () {
                          return Future<void>.value();
                        },
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
                                      uid: data['id'],
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
                        expandedHeight: 115.0,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const <StretchMode>[
                            StretchMode.blurBackground,
                          ],
                          background: Container(
                            color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 65, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText //Welcome Header
                                      (
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Hello,',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "\n${data['username']}",
                                          style: TextStyle(
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        InkWell(
                                          child: Container(
                                            width: 120,
                                            height: 38,
                                            decoration: BoxDecoration(
                                                //color: Color(0xffFAEBD4),
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: Center(
                                                child: RichText(
                                                    text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                    child: Icon(
                                                  CupertinoIcons.music_albums,
                                                  size: 16,
                                                )),
                                                TextSpan(
                                                    text: '  Library',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ))),
                                          ),
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: LibraryPage());
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          child: Container(
                                            width: 120,
                                            height: 38,
                                            decoration: BoxDecoration(
                                                //color: Color(0xffFAEBD4),
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: RichText(
                                                  text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                    CupertinoIcons.list_bullet,
                                                    size: 16,
                                                  )),
                                                  TextSpan(
                                                      text: '  Playlists',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              )),
                                            )),
                                          ),
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: LibraryPage());
                                          },
                                        ),
                                      ],
                                    ),
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
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Releases',
                                            style: TextStyle(
                                                letterSpacing: 1.2,
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                pushNewScreen(context,
                                                    screen: ReleaseFeed());
                                              },
                                              icon: Icon(Icons.expand_more))
                                        ],
                                      ),
                                      Text(
                                        "find out what's new",
                                        style: TextStyle(
                                            letterSpacing: 1.3,
                                            color: Colors.white54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  height: 180,
                                  child: ListView //New Releases
                                      (
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      SizedBox(width: 15),
                                      InkWell(
                                        onTap: () {
                                          pushNewScreen(context,
                                              withNavBar: false,
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                              screen: Player(
                                                  player: widget.homePlayer,
                                                  playlist:
                                                      ConcatenatingAudioSource(
                                                          children: [
                                                        AudioSource.uri(
                                                            Uri.parse(
                                                                'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/tracks%2FJoji_-_Gimme_Love.mp3?alt=media&token=6a5d7b4f-0e88-4ed7-802f-ae60ccc2b418'),
                                                            tag: MediaItem(
                                                                id: '1',
                                                                title:
                                                                    'Gimme Love',
                                                                artist: 'Joji',
                                                                artUri: Uri.parse(
                                                                    'https://images.complex.com/complex/image/upload/c_fill,dpr_auto,f_auto,fl_lossy,g_face,q_auto,w_1280/m7ll2zgzoxostwcoswzi.png')))
                                                      ])));
                                        },
                                        child: artistRelease(
                                            'https://upload.wikimedia.org/wikipedia/en/1/1b/Joji_-_Nectar.png',
                                            'Gimme Love',
                                            'Joji',
                                            'single'),
                                      ),
                                      SizedBox(width: 15),
                                      artistRelease(
                                          'https://upload.wikimedia.org/wikipedia/en/c/c1/The_Weeknd_-_After_Hours.png',
                                          'After Hours',
                                          'The Weeknd',
                                          'album'),
                                      SizedBox(width: 15),
                                      artistRelease(
                                          'https://upload.wikimedia.org/wikipedia/en/b/b8/Mura_Masa_album.jpg',
                                          'Mura Masa',
                                          'Mura Masa',
                                          'album'),
                                      SizedBox(width: 15),
                                      artistRelease(
                                          'https://images.genius.com/3e19af5cd67d794b62e6b0fe59de0cde.500x500x1.jpg',
                                          'Between Days',
                                          'Far Caspian',
                                          'single'),
                                      SizedBox(width: 15),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Trails',
                                              style: TextStyle(
                                                  letterSpacing: 1.2,
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "check what everyone's upto",
                                              style: TextStyle(
                                                  letterSpacing: 1.3,
                                                  color: Colors.white54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 110,
                                          child: ListView.builder(
                                            itemCount: trailList.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(left: 15),
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Connect',
                                        style: TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Find new people to work with",
                                        style: TextStyle(
                                            letterSpacing: 1.3,
                                            color: Colors.white54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        width: sWidth - 30,
                                        height: 125,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1618367588411-d9a90fefa881?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=967&q=80'))),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Discover',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40),
                                              ),
                                              Text(
                                                'new artists',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    fontSize: 20),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(height: 70),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ])),
                    ]),
              ),
            );
          } else {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
