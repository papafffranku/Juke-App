import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'category.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xff5AE0D3), Color(0xff5A62D3)],
    ).createShader(
      Rect.fromLTWH(70.0, 0.0, 200.0, 70.0),
    );
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            leading: Icon(Icons.arrow_back_ios_sharp),
            backgroundColor: Colors.black,
            elevation: 2.0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.black,
                    child: Column(children: [
                      Text(
                        'LIBRARY',
                        style: TextStyle(
                            foreground: Paint()..shader = linearGradient,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              category(Icons.album_sharp, 'Albums',
                                  Colors.indigoAccent, 0),
                              category(
                                  Icons.person, 'Artists', Colors.redAccent, 1),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              category(
                                  Icons.piano, 'Genres', Colors.greenAccent, 0),
                              category(Icons.music_note, 'Tracks',
                                  Colors.amberAccent, 1),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                    ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'recently played',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget category(IconData icon, String text, Color color, int catIndex) {
    return Container(
      child: Column(
        children: [
          InkWell(
              //splashColor: Colors.transparent,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 3.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              onTap: () {
                pushNewScreen(
                  context,
                  screen: TracksPage(selectedOption: catIndex),
                );
              }),
          SizedBox(height: 10),
          Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
