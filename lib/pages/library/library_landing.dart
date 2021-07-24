import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';

import 'category.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Color(0xff0e0e15),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff0e0e15),
            title: Text('Library'),
          ),
          backgroundColor: Color(0xff0e0e15),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      category(CupertinoIcons.music_note, 'Tracks',
                          Colors.amberAccent, 0),
                      category(CupertinoIcons.music_albums, 'Albums',
                          Colors.cyanAccent, 1),
                      category(CupertinoIcons.person, 'Artists',
                          Colors.pinkAccent, 2),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Recently Played',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  trackTile(
                      'SLUGGER (feat. NOT & slowthai)',
                      'Kevin Abstract',
                      3500,
                      'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                  trackTile('Swing Lynn', 'Harmless', 2890000,
                      'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                  trackTile('Corso', 'Tyler, The Creator', 9000000,
                      'https://images.genius.com/9b50709a30fbb0eee802ba391af0eb43.999x999x1.png'),
                  trackTile('Weirdo', 'Fatter', 9000000,
                      'https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/d5/30/4d/d5304d50-b5a4-db22-2db6-82019159ffd6/0.jpg/400x400bb.jpeg'),
                  trackTile('Feel Good Inc.', 'Gorillaz', 900,
                      'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
                  trackTile('Green Grass', 'Ellie Dixon', 52343,
                      'https://is2-ssl.mzstatic.com/image/thumb/Music125/v4/1d/18/46/1d184666-be67-5f81-660a-a2b36b7f7c8b/195999965284.jpg/400x400cc.jpg'),
                  trackTile(
                      'SLUGGER (feat. NOT & slowthai)',
                      'Kevin Abstract',
                      3500,
                      'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                  trackTile('Swing Lynn', 'Harmless', 2890000,
                      'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                  trackTile('Feel Good Inc.', 'Gorillaz', 900,
                      'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
                ],
              ),
            ),
          )),
    );
  }

  Widget category(IconData icon, String text, Color color, int catIndex) {
    return Container(
      child: Column(
        children: [
          InkWell(
              splashColor: Colors.transparent,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xff1f1f26),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: color,
                      size: 30,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CategoriesPage(selectedOption: catIndex)),
                );
              }),
          SizedBox(height: 15),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
