import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/Firebase%20Auth%20Helper/Pro.dart';
import 'package:lessgoo/pages/explore/explore.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
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
    return [
      HomePage(),
      ExplorePage(),
      ProfilePage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.house_fill),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).accentColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Explore"),
        activeColorPrimary: Theme.of(context).accentColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.infinite),
        title: ("Connect"),
        activeColorPrimary: Theme.of(context).accentColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.group_solid),
        title: ("Community"),
        activeColorPrimary: Theme.of(context).accentColor,
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

    return Scaffold(
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
              navBarStyle: NavBarStyle.style13,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Image.network(
                                  'https://images.squarespace-cdn.com/content/v1/53b6eb62e4b06e0feb2d8e86/1595624196054-EHA9AOE535UCPQ1I7YNV/SamSpratt_NoPressure_CoverArt_Tracklist_clean.jpg?format=1500w'),
                            ),
                            Icon(
                              CupertinoIcons.play,
                              size: 30,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(color: Colors.yellow),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget botbut() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Container(
                width: 60,
                height: 60,
                child: Center(
                    child: Icon(
                  CupertinoIcons.play,
                  size: 30,
                )),
                decoration:
                    BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
              )),
        ],
      ),
    );
  }
}
