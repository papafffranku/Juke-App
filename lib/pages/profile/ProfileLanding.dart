import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/pages/activityfeed/activityfeed.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/pages/profile/Settings.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfileLanding extends StatefulWidget {
  const ProfileLanding({Key? key}) : super(key: key);

  @override
  _ProfileLandingState createState() => _ProfileLandingState();
}

class _ProfileLandingState extends State<ProfileLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          landingPageHeader(
              context, 'Profile', Icons.settings, ProfileSettings()),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                FutureBuilder<DocumentSnapshot>(
                    future: userRef.doc(currentUserId).get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          data['username'],
                          style: TextStyle(fontSize: 24),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                Spacer(),
                InkWell(
                  onTap: () => pushNewScreen(context,
                      screen: ProfilePage(searchID: currentUserId)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff3B3F46),
                        borderRadius: BorderRadius.circular(15)),
                    height: 40,
                    width: 120,
                    child: Center(child: Text('View Profile')),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    'Library',
                    style: TextStyle(fontSize: 24),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios)
                ],
              )),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () => pushNewScreen(context, screen: ActivityFeed()),
                child: Row(
                  children: [
                    Text(
                      'Activity',
                      style: TextStyle(fontSize: 24),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
