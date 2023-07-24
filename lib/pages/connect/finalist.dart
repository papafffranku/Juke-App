import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import '../swiper/modalswipe.dart';

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

class finalist extends StatefulWidget {
  const finalist({Key? key}) : super(key: key);

  @override
  State<finalist> createState() => _finalistState();
}

class _finalistState extends State<finalist> {
  List bro = ['singer', 'producer', 'instrumentalist'];
  int? totalusers;
  int? numero;
  List? connectnumbers;

  @override
  void initState() {
    super.initState();
    gettotalusers();
  }

  Future<void> gettotalusers() async {
    Random random = new Random();
    int? personalconnectnumber;
    List templist = [];
    await total.doc('totalnumber').get().then((value) async {
      var fields = value.data();
      totalusers = (fields!['number']);
    });
    //TODO:uid link vro
    await usersRef
        .doc('BiSqv7gK2yd9sNL8XFdbb31ZArt2')
        .get()
        .then((value) async {
      var fields = value.data();
      personalconnectnumber = (fields!['connectNumber']);
    });
    for (var i = 0; i <= totalusers!; i++) {
      templist.add(i);
    }
    templist = templist..shuffle();
    templist.removeRange(3,
        templist.length); //Number of swipes basically, keeps ony 3 in the list
    setState(() {
      connectnumbers = templist;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Query<Map<String, dynamic>> randomQuery =
        usersRef.where("connectNumber", whereIn: connectnumbers).limit(3);
    //TODO: add shuffle array here, thats all lul

    Widget _buildTile(String? title) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              title!,
              style: TextStyle(color: Colors.black),
            ),
          )),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Theme.of(context).hintColor));
    }

    Widget Mainstuff() {
      return Stack(
        children: [
          Container(
            width: double.infinity,
            height: height,
            child: Image.network(
              'https://c4.wallpaperflare.com/wallpaper/896/353/111/amoled-anime-cowboy-bebop-hd-wallpaper-preview.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Color(0xff23252B).withOpacity(0.9),
              width: double.infinity,
              height: width - 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'username',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                CupertinoIcons.chevron_forward,
                                size: 30,
                                color: Colors.black,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Looking For:'),
                        Container(
                          height: 42,
                          width: width - 130,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: bro.map((item) {
                                return _buildTile(item);
                              }).toList()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'the thoughtful, multifaceted arguments that your professors expect depend on them. Without good paragraphs, you simply cannot clearly convey sequential points and their relationships to one another.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width - 170,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                            'Audio Player',
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).hintColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 30,
                                color: Colors.black,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
                stops: [0.005, 0.995],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
        body: Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: randomQuery.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              final List username =
                  snapshot.data!.docs.map((doc) => doc['username']).toList();
              final List bio =
                  snapshot.data!.docs.map((doc) => doc['bio']).toList();
              final List picture =
                  snapshot.data!.docs.map((doc) => doc['avatarUrl']).toList();
              final List tag =
                  snapshot.data!.docs.map((doc) => doc['tag']).toList();
              final List lookout =
                  snapshot.data!.docs.map((doc) => doc['lookout']).toList();
              return Swiper(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                'https://www.arabianbusiness.com/cloud/2022/09/26/Kanye-West.jpg',
                                height: height,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            GlassContainer(
                              height: width*0.3,
                              width: width,
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              border: Border.all(color: Colors.transparent),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          connectnumbers.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      tags(['singer', 'Producer', 'Instrumentalist', 'Guitarist'],
                                          width),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Container(
                                width: width + 100,
                                height: height,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.0, 0.9],
                                      colors: [
                                        Colors.transparent,
                                        Color(0xff25282F),
                                      ],
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: height * 0.65),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: width * 0.82,
                                                child: Text(
                                                  username[index],
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .chat_bubble_fill,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                          color: Colors.white,
                                                          blurRadius: 15.0)
                                                    ],
                                                    size: 30,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Looking for:   ",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              tags2([
                                                'singer',
                                                'Producer',
                                                'Instrumentalist',
                                                'Guitarist'
                                              ], width)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: width * 0.95,
                                                child: Text(
                                                  "Reloaded 1 of 1840 libraries in 424ms.D/EGL_emulation( 7900): app_time_stats: avg=5154.91ms min=69.34ms max=10240.48ms count=2",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.play_fill,
                                                size: 50,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                      color: Colors.white,
                                                      blurRadius: 15.0)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                autoplay: false,
                itemCount: 3,
                scrollDirection: Axis.vertical,
                pagination:
                    const SwiperPagination(alignment: Alignment.centerLeft),
                control: const SwiperControl(),
              );
            }
            return Text('Something went wrong');
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Connect',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget tags(List strs, double width) {
    return Container(
      height: 38,
      width: width * 0.9,
      child: Container(
          child: CupertinoScrollbar(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: strs.map((strone) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff25282F),
              ),
              child: Text(strone),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
            );
          }).toList(),
        ),
      )),
    );
  }

  Widget tags2(List strs, double width) {
    return Container(
      width: width * 0.69,
      height: 38,
      child: Container(
          child: CupertinoScrollbar(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: strs.map((strone) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff25282F),
                border: Border.all(color: Colors.white30)
              ),
              child: Text(strone),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
            );
          }).toList(),
        ),
      )),
    );
  }
}
