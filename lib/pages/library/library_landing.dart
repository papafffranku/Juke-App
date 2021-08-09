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
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.black,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_sharp)),
                        ),
                      ),
                      Text(
                        'LIBRARY',
                        style: TextStyle(
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
                            padding: const EdgeInsets.all(20.0),
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
                      SizedBox(height: 15),
                      trackTile(
                          'SLUGGER (feat. NOT & slowthai)',
                          'Kevin Abstract',
                          'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                      trackTile('Swing Lynn', 'Harmless',
                          'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                      trackTile('Corso', 'Tyler, The Creator',
                          'https://images.genius.com/9b50709a30fbb0eee802ba391af0eb43.999x999x1.png'),
                      trackTile('Weirdo', 'Fatter',
                          'https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/d5/30/4d/d5304d50-b5a4-db22-2db6-82019159ffd6/0.jpg/400x400bb.jpeg'),
                      trackTile('Feel Good Inc.', 'Gorillaz',
                          'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
                      trackTile('Green Grass', 'Ellie Dixon',
                          'https://is2-ssl.mzstatic.com/image/thumb/Music125/v4/1d/18/46/1d184666-be67-5f81-660a-a2b36b7f7c8b/195999965284.jpg/400x400cc.jpg'),
                      trackTile(
                          'SLUGGER (feat. NOT & slowthai)',
                          'Kevin Abstract',
                          'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                      trackTile('Swing Lynn', 'Harmless',
                          'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                      trackTile('Feel Good Inc.', 'Gorillaz',
                          'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
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
                  screen: CategoriesPage(selectedOption: catIndex),
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
