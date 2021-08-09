import 'package:flutter/material.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';

class AlbumViewer extends StatefulWidget {
  const AlbumViewer({Key? key}) : super(key: key);

  @override
  _AlbumViewerState createState() => _AlbumViewerState();
}

class _AlbumViewerState extends State<AlbumViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.pink,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://i.redd.it/vz918rh5w3t41.jpg'))),
                child: Container(
                  height: 620,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Theme.of(context).primaryColor
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.4)),
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.arrow_back_ios_sharp)),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.4)),
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.more_vert)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'album',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Nectar',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite_border,
                                              size: 30)),
                                      SizedBox(width: 15),
                                      CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).accentColor,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.shuffle,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                'Joji',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'My third studio album.',
                                style: TextStyle(color: Colors.white54),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  trackTile('Ew', 'Joji', 'coverart'),
                  trackTile('Modus', 'Joji', 'coverart'),
                  trackTile('Daylight', 'Joji', 'coverart'),
                  trackTile('Run', 'Joji', 'coverart'),
                  trackTile('Tick Tock', 'Joji', 'coverart'),
                ],
              ),
            ],
          ),
        )));
  }
}
