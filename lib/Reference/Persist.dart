import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/pages/explore/explore.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/player/player.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Persist extends StatefulWidget {
  const Persist({Key? key}) : super(key: key);

  @override
  _PersistState createState() => _PersistState();
}

class _PersistState extends State<Persist> {
  late AudioPlayer _player;
  @override
  void initState() {
    _player = AudioPlayer();
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(homePlayer: _player),
      ExplorePage(),
      ProfilePage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.house_fill,
        ),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Explore"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.infinite),
        title: ("Connect"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.group_solid),
        title: ("Community"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }

  late PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    String imagis =
        'https://images.complex.com/complex/images/c_fill,f_auto,g_center,w_1200/fl_lossy,pg_1/hcjrqlvc6dfhpjxob9nt/cudi';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
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
              navBarStyle: NavBarStyle.style9,
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: miniplayer(_player, screenwidth))
          ],
        ),
      ),
    );
  }

  Widget miniplayer(AudioPlayer trackData, double screenwidth) {
    return StreamBuilder<SequenceState?>(
        stream: _player.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state?.sequence.isEmpty ?? true) return SizedBox();
          final metadata = state!.currentSource!.tag as MediaItem;
          return StreamBuilder<PlayerState?>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final playing = playerState?.playing;
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
                              SizedBox(width: 10),
                              if (playing == true)
                                Icon(CupertinoIcons.play_fill),
                              SizedBox(width: 20),
                              InkWell(
                                onTap: () {
                                  pushToPlayer();
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        metadata.title,
                                        style: TextStyle(fontSize: 18),
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
        });
  }

  void pushToPlayer() {
    pushNewScreen(context,
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
        screen: Player(player: _player, playlist: null));
  }
}
