import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/pages/activityfeed/activityfeed.dart';
import 'package:lessgoo/pages/connect/connectPage.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/library/likedTracks.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/pages/profile/Settings.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

final fbRef = FirebaseFirestore.instance.collection('Feedback');

class ProfileLanding extends StatefulWidget {
  const ProfileLanding({Key? key}) : super(key: key);

  @override
  _ProfileLandingState createState() => _ProfileLandingState();
}

class _ProfileLandingState extends State<ProfileLanding> {
  final TextEditingController feedcontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
        children: [
            landingPageHeader(
                context, 'Profile', Icons.settings, ProfileSettings()),
            SizedBox(
              height: 15,
            ),
            FadeIn(
              duration: Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                        future: userRef.doc(currentUserId).get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                data['username'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 24),
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    Spacer(),
                    InkWell(
                      onTap: ()async => Future.microtask((){
                        pushNewScreen(context,
                            screen: ProfilePage(searchID: currentUserId),
                        pageTransitionAnimation: PageTransitionAnimation.cupertino);
                      }),
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
            ),
            SizedBox(
              height: 30,
            ),
            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 15),
            //     child: InkWell(
            //       onTap: () => pushNewScreen(context, screen: LikedTracks()),
            //       child: Row(
            //         children: [
            //           Text(
            //             'Library',
            //             style: TextStyle(fontSize: 24),
            //           ),
            //           Spacer(),
            //           Icon(Icons.arrow_forward_ios)
            //         ],
            //       ),
            //     )),
            // SizedBox(
            //   height: 30,
            // ),
            FadeIn(
              duration: Duration(milliseconds: 300),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: InkWell(
                    onTap: () => pushNewScreen(context, screen: ActivityFeed()),
                    child: Container(
                      height: 35,
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
                    ),
                  )),
            ),
            SizedBox(height: 350,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                            controller: feedcontrol,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "We'd love to hear your feedback",
                              hintStyle: TextStyle(color: Colors.grey)
                            ),
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Theme.of(context).accentColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Hit us up!',style: TextStyle(color: Colors.black,fontSize: 18),),
                        )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          sendfeedback();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Theme.of(context).accentColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.send_rounded,color: Colors.black,),
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
          )),
    );
  }

  void sendfeedback(){
    if(feedcontrol.text.isEmpty){
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Snackbar('Please enter your thoughts', context);
    }
    else{
      fbRef.add({
        "id": uid,
        "username": feedcontrol.text.toString(),
      });
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Snackbar('Sent Successfully', context);
    }
  }

}
