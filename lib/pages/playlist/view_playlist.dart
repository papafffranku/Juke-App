import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';

class PlaylistViewer extends StatefulWidget {
  const PlaylistViewer({Key? key}) : super(key: key);

  @override
  _PlaylistViewerState createState() => _PlaylistViewerState();
}

class _PlaylistViewerState extends State<PlaylistViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back_ios_sharp)),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.more_vert)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://i.redd.it/6edffsd31bn31.jpg'))),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff4E4B6E),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'playtime: 1h 30m',
                          style: TextStyle(color: Colors.white54),
                        ),
                        Text(
                          '345 tracks',
                          style: TextStyle(color: Colors.white54),
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'playlist',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Spooky Lamehe',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border)),
                            SizedBox(width: 10),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Color(0xffFAEBD4),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.shuffle,
                                color: Colors.black,
                              )),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      'Vishaal D.',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'My third studio album.',
                      style: TextStyle(color: Colors.white54),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    trackTile('Ew', 'Joji',
                        'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b7fd92108782021.5fc5820ec90ba.png'),
                    trackTile('Modus', 'Joji',
                        'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b7fd92108782021.5fc5820ec90ba.png'),
                    trackTile('Daylight', 'Joji',
                        'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b7fd92108782021.5fc5820ec90ba.png'),
                    trackTile('Run', 'Joji',
                        'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b7fd92108782021.5fc5820ec90ba.png'),
                    trackTile('Tick Tock', 'Joji',
                        'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b7fd92108782021.5fc5820ec90ba.png'),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
