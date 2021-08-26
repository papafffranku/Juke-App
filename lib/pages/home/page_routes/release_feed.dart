import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReleaseFeed extends StatefulWidget {
  const ReleaseFeed({Key? key}) : super(key: key);

  @override
  _ReleaseFeedState createState() => _ReleaseFeedState();
}

class _ReleaseFeedState extends State<ReleaseFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'releases',
                    style: TextStyle(
                        letterSpacing: 1.2,
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    releaseTile(
                        'https://upload.wikimedia.org/wikipedia/en/1/1b/Joji_-_Nectar.png',
                        'Gimme Love',
                        'Joji',
                        'single',
                        "Gimme Love is a song by Japanese singer-songwriter Joji. It was released on 16 April 2020 through 88rising, as the third single from Joji's second studio album Nectar"),
                    SizedBox(height: 25),
                    releaseTile(
                        'https://upload.wikimedia.org/wikipedia/en/c/c1/The_Weeknd_-_After_Hours.png',
                        'After Hours',
                        'The Weeknd',
                        'album',
                        " After Hours is the fourth studio album by Canadian singer the Weeknd, released on March 20, 2020, by XO and Republic Records. Primarily produced by the Weeknd, it features a variety of producers, including DaHeala, Illangelo, Max Martin, Metro Boomin, and OPN, most of whom the Weeknd had worked with previously. The standard edition of the album has no features, although the remixes edition contains guest appearances from Chromatics and Lil Uzi Vert. Thematically, After Hours explores promiscuity, overindulgence, and self-loathing."),
                    SizedBox(height: 25),
                    releaseTile(
                        'https://upload.wikimedia.org/wikipedia/en/b/b8/Mura_Masa_album.jpg',
                        'Mura Masa',
                        'Mura Masa',
                        'album',
                        "Mura Masa is the self-titled debut studio album by Guernsey-born music producer Alex Crossan, under his alias Mura Masa. It was released on 14 July 2017 by Polydor, Interscope, Downtown and Anchor Point Records. The album was produced and recorded by Crossan from 2014 to 2016, and has guest features by A. K. Paul, ASAP Rocky, Bonzai, Charli XCX, Christine and the Queens, Damon Albarn, Desiigner, Jamie Lidell, NAO and Tom Tripp. It received nominations for Best Dance/Electronic Album and Best Recording Package."),
                    SizedBox(height: 25),
                    releaseTile(
                        'https://images.genius.com/3e19af5cd67d794b62e6b0fe59de0cde.500x500x1.jpg',
                        'Between Days',
                        'Far Caspian',
                        'single',
                        "Leeds trio Far Caspian have just released their debut EP ‘Between Days’ via Dance To The Radio. Featuring recent singles ‘Blue’, ‘The Place’ and ‘Let’s Go Outside’, it’s a laid-back listen with enough warmth to shake off these chilly November days. Frontman and guitarist Joel Johnston – originally from Ireland – runs us through his band’s new release, track by track."),
                    SizedBox(height: 25),
                    releaseTile(
                        'https://media.pitchfork.com/photos/5929ae46c0084474cd0c188c/1:1/w_600/04192b63.jpg',
                        'Currents',
                        'Tame Impala',
                        'album',
                        "Currents is the third studio album by Australian musical project Tame Impala. It was released on 17 July 2015 by Modular Recordings and Universal Music Australia. In the United States it was released by Interscope Records and Fiction Records, while Caroline International released it in other international regions. Like the group's previous two albums, Currents was written, recorded, performed, and produced by primary member Kevin Parker. For the first time, Parker mixed the music and recorded all instruments by himself; the album featured no other collaborators."),
                    SizedBox(height: 25),
                  ],
                )),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget releaseTile(String imgUrl, String trackName, String artistName,
      String releaseType, String desc) {
    return Container(
        child: Row(
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image: NetworkImage(imgUrl))),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 130,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 168,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('album',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).accentColor)),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                  Text(artistName.toLowerCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white54)),
                  Text(
                    trackName,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width - 168,
                    child: Text(
                      desc,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Colors.white54),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.favorite_border,
                          color: Colors.white54, size: 18),
                      Text('  32.1k',
                          style: TextStyle(
                            color: Colors.white54,
                          )),
                      SizedBox(width: 10),
                      Icon(Icons.chat_bubble_outline,
                          color: Colors.white54, size: 20),
                      Text(
                        '  1.2k',
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ],
    ));
  }
}
