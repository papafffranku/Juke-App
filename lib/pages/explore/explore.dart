import 'dart:ui';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lessgoo/pages/explore/SearchPage.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    double sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        body: ColorfulSafeArea(
            child: ListView(children: [
          landingPageHeader2(
              context, "Explore", CupertinoIcons.search, SearchPage()),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        height: sHeight / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1515210986222-9a86ccb8f4a9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1054&q=80'))),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Rising Artists',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                            width: sWidth / 3,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Color(0xffFAEBD4)),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Charts',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).backgroundColor),
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1556139930-c23fa4a4f934?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'))),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Genres',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                            width: (sWidth / 2) - 30,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xff655C7F),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Top\nSongs',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color(0xff4E4B6E),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Top\nAlbums',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                        width: double.infinity,
                        height: sHeight / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1444990689320-bd2a7a839644?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1507&q=80'))),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'New',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).backgroundColor),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                color: Colors.black87,
                height: MediaQuery.of(context).copyWith().size.height,
                width: MediaQuery.of(context).copyWith().size.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 350),
                  child: Center(child: Text('Other features coming soon',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
                ),
              ),
            ],
          )
        ])));
  }
}
