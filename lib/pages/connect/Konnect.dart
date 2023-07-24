import 'dart:math';

import 'package:animation_list/animation_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final total = FirebaseFirestore.instance.collection('totalusers');
final uid = FirebaseAuth.instance.currentUser!.uid;
final items = [
  'Singer',
  'Producer',
  'Instrumentalist',
  'Cover Artist',
  'Sound Engineer'
];

class konnect extends StatefulWidget {
  const konnect({Key? key}) : super(key: key);

  @override
  State<konnect> createState() => _konnectState();
}

class _konnectState extends State<konnect> {
  int? totalusers;
  String abc = 'none';
  String tagKeyword = 'weasdd';
  String filterString='';

  @override
  void initState() {
    gettotalusers();
    super.initState();
  }

  Future<void> gettotalusers() async {
    await total.doc('totalnumber').get().then((value) async {
      var fields = value.data();
      totalusers = (fields!['number']);
    });
  }



  DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
      value: item,
      child: FadeIn(
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,
        child: Text(
          item,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Query<Map<String, dynamic>> randomQuery =
    usersRef.where("connectNumber", isEqualTo: 2).limit(3);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                children: [
                  Text(
                    totalusers.toString(),
                    style: TextStyle(
                        color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              maincontent(width, randomQuery.snapshots())
            ],
          ),
        ),
      ),
    );
  }


  //new one
  Widget newTrack(double width, String trackname, String artist,
      String coverimage, String avatar, String tag) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              image: NetworkImage(
                coverimage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: RadialGradient(
              center: Alignment(-0.8, 0.8),
              colors: [Colors.blue, Colors.transparent],
              radius: 2.4,
              stops: [0.005, 0.995],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: width * 0.25,
                    width: width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(
                          coverimage,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width*0.6,
                      child: Text(
                    trackname,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  )),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: artist,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        WidgetSpan(
                          child: Icon(
                            CupertinoIcons.forward,
                            color: Theme.of(context).hintColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    Text(
                      'Pop',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CircleAvatar(
                      radius: width * 0.125,
                      backgroundImage: NetworkImage(
                        avatar,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget maincontent(
      double width, Stream<QuerySnapshot<Map<String, dynamic>>> query) {
    return Column(
      children: [
        Text('data'),
        StreamBuilder<QuerySnapshot>(
          stream: query,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return AnimationList(
              physics: NeverScrollableScrollPhysics(),
              duration: 1000,
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print(snapshot.data?.size); // so fucking stupid
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: newTrack(width, data['email'], data['username'],
                      data['avatarUrl'], data['avatarUrl'], data['email']),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
