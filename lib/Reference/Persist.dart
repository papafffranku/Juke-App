import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/pages/channel/channels.dart';
import 'package:lessgoo/pages/connect/connectPage.dart';
import 'package:lessgoo/pages/explore/explore.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/player/player.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Persist extends StatefulWidget {
  const Persist({Key? key}) : super(key: key);

  @override
  _PersistState createState() => _PersistState();
}

class _PersistState extends State<Persist> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [HomePage(), ExplorePage(), ConnectPage(), ChannelPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.house_fill,
        ),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white54,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Explore"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white54,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.infinite),
        title: ("Connect"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white54,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.group_solid),
        title: ("Community"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white54,
      ),
    ];
  }

  late PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            backgroundColor: Colors.black,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 400),
              curve: Curves.fastLinearToSlowEaseIn,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 400),
            ),
            navBarStyle: NavBarStyle.style12,
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: miniplayer(audioPlayer, screenwidth))
        ],
      ),
    );
  }

  Widget miniplayer(AudioPlayer trackData, double screenwidth) {
    return StreamBuilder<SequenceState?>(
        stream: audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state?.sequence.isEmpty ?? true) return SizedBox();
          final metadata = state!.currentSource!.tag as MediaItem;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  height: 55,
                  width: screenwidth - 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(metadata.artUri.toString())),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Row(
                      children: [
                        buttonControl(),
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            pushToPlayer();
                          },
                          child: Expanded(
                            child: Container(
                              width: screenwidth - 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    metadata.title,
                                    style: TextStyle(
                                        fontSize: 17,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    metadata.artist.toString(),
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.favorite_outline),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget buttonControl() {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (playing != true) {
          return IconButton(
            icon: Icon(Icons.play_circle_filled),
            iconSize: 35,
            onPressed: audioPlayer.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: Icon(Icons.pause_circle_filled),
            iconSize: 35,
            onPressed: audioPlayer.pause,
          );
        } else {
          return IconButton(
            icon: Icon(Icons.replay),
            iconSize: 35,
            onPressed: () => audioPlayer.seek(Duration.zero,
                index: audioPlayer.effectiveIndices!.first),
          );
        }
      },
    );
  }

  void pushToPlayer() {
    pushNewScreen(context,
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
        screen: Player(player: audioPlayer, playlist: null));
  }
}
