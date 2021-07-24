import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lessgoo/pages/home/tools/album_tile.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';
import 'package:lessgoo/pages/profile/trackwidget/bio.dart';
import 'package:lessgoo/pages/profile/trackwidget/collab.dart';
import 'package:lessgoo/pages/profile/trackwidget/featured_track.dart';

class OtherProfile extends StatefulWidget {
  const OtherProfile({Key? key}) : super(key: key);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {

  String Background='https://images.unsplash.com/photo-1579546929662-711aa81148cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80';
  String Vinland='https://i1.sndcdn.com/artworks-000573835055-8owmgt-t500x500.jpg';

  @override
  Widget build(BuildContext context) {

    double screenwidth=MediaQuery. of(context). size. width;
    double screenheight=MediaQuery. of(context). size. height;

    return Scaffold(
      backgroundColor: Color(0xff0e0e15),
      body: ColorfulSafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 475,
                width: screenwidth,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(Background))),
              ),
              Container //Gradient
                (
                height: 475,
                decoration: BoxDecoration(
                    color: Color(0xff0e0e15), gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color(0xff0e0e15).withOpacity(0.2),
                      Color(0xff0e0e15),
                    ],
                    stops: [0.0, 1.0])),
              ),
              Padding(
                padding: const EdgeInsets.only(top:300.0),
                child: Container(
                  width: screenwidth,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vikram Sharma",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                      Text(
                        "Singer, Producer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[400], fontSize: 18),
                      ),

                      SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "125",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Songs",
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Text(
                                  "1,290",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "followers",
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Text(
                                  "25M",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("following",
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 75,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Center(
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //profile background
              Padding(
                padding: const EdgeInsets.only(top: 475.0),
                child: Container(
                  color: Color(0xff0e0e15),
                  width: screenwidth,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Featured('https://img.discogs.com/UB8uZXucpxGcbdrtqoVZFHWZ2Cw=/fit-in/600x598/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-10268904-1494414512-7307.jpeg.jpg', 'Someone To Stay', 'Vikram Sharma','2021'),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Top Songs',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700)),
                                    Text('See All',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  children: [
                                    trackTile(
                                        'Vinland Saga',
                                        'Vikram Sharma',
                                        129985,
                                        'https://i1.sndcdn.com/artworks-000573835055-8owmgt-t500x500.jpg'),
                                    trackTile(
                                        'Orange Soda',
                                        'Vikram Sharma',
                                        27760,
                                        'https://upload.wikimedia.org/wikipedia/en/thumb/a/a6/Baby_Keem_-_Orange_Soda.png/220px-Baby_Keem_-_Orange_Soda.png'),
                                    trackTile('Bad', 'Vikram Sharma', 300,
                                        'https://s.abcnews.com/images/Entertainment/MJ-bad-1987-170831_4x5_992.jpg'),
                                    trackTile(
                                        'Sinnerman',
                                        'Vikram Sharma',
                                        10455,
                                        'https://m.media-amazon.com/images/I/811Fs99RivL._SS500_.jpg'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Albums',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700)),
                                      Text('See All',
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                    height: 200,
                                    //width: 120,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        albumTile('https://upload.wikimedia.org/wikipedia/en/1/1b/Joji_-_Nectar.png', 'Nectar','2021'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        albumTile('https://daddykool.com/Photo/418464302795', 'Circles','2020'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        albumTile('https://ichef.bbci.co.uk/news/976/cpsprodpb/61CC/production/_106763052_tdcc_cover-nc.jpg', 'Two Door Cinema Club','2019'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        albumTile('https://vman.com/wp-content/uploads/sites/2/2019/10/699d9ba27c686b9e0f7858b6d778fb23.1000x1000x1.png', 'Dusk','2019'),
                                      ],
                                    )),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Bio(),
                              SizedBox(
                                height: 20,
                              ),
                              Collabs(),
                              SizedBox(
                                height: 20,
                              ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.facebook_rounded,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {},
                                  //   child: Icon(
                                  //     Entypo.instagram,
                                  //     size: 40,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 40)
                            ],
                          )), //details
                    ],
                  ),
                ),
              ), //main content

            ],
          ),
        ),
      ),
    );
  }
}
