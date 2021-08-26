import 'dart:ui';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> categories = ['Trending', 'For You'];
  int counter = 0;
  String Profile =
      'https://www.classifapp.com/wp-content/uploads/2017/09/avatar-placeholder.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ColorfulSafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "explore",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Artists or songs',
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.none,
                          color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Color(0xff1e1e2d),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top Tracks',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700)),
                    Text('See All',
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                  items: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.pinimg.com/originals/a1/46/b8/a146b831d0540717d5ab926760652abd.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/602f4731226337.5646928c3633f.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.complex.com/complex/images/c_fill,f_auto,g_center,w_1200/fl_lossy,pg_1/hcjrqlvc6dfhpjxob9nt/cudi'),
                              fit: BoxFit.cover)),
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn6.f-cdn.com/contestentries/1485199/27006121/5ca3e39ced7f1_thumb900.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 210.0),
                          child: Text(
                            "Bingo was his name-o",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                backgroundColor: Colors.black),
                          ),
                        ))
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://static-cse.canva.com/blob/141792/albumcover-image10.jpg'),
                              fit: BoxFit.cover)),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    viewportFraction: 0.5,
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 35,
                  //width: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: 8,
                      ),
                      Tag('New Artists'),
                      SizedBox(
                        width: 10,
                      ),
                      Tag('Latest Singles'),
                      SizedBox(
                        width: 10,
                      ),
                      Tag('Trending'),
                      SizedBox(
                        width: 10,
                      ),
                      Tag('Hip-Hop'),
                      SizedBox(
                        width: 10,
                      ),
                      Tag('Pop'),
                      SizedBox(
                        width: 10,
                      ),
                      Tag('Rock'),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top Artists',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700)),
                    Text('See All',
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Artist(Profile, 'Jack Harlow', 'Singer'),
                  Artist(Profile, 'Swedish House Mafia', 'Producer'),
                  Artist(Profile, 'Imagine Dragons', 'Cover Artist'),
                  Artist(Profile, 'Joji', 'Singer,Producer'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget Tag(String s) {
  return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
        child: Center(
          child: Text(s,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color(0xff2c2c36)));
}

Widget Artist(String profile, String name, String sub) {
  return Container(
    child: ListTile(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(profile),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          name,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        subtitle: Text(
          sub,
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        )),
  );
}

class DataSearch extends SearchDelegate<String> {
  final searches = [
    "Hello",
    "Hi",
    "How Are",
    "This one",
    "YounG",
    "Blood on the PooPoo"
  ];

  final recent = ["Hello", "This one"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear_rounded))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Card(
      color: Colors.red,
      shape: StadiumBorder(),
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestions = query.isEmpty
        ? recent
        : searches.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.search_rounded),
        title: RichText(
          text: TextSpan(
              text: searches[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: searches[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestions.length,
    );
  }
}
