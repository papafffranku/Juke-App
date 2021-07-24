import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'music_controller.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);


  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  //Music Controls
  bool playing = false;
  IconData playBtn = Icons.play_circle_filled;

  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  void btnMenu(){
    showModalBottomSheet(context: context, builder: (BuildContext bc){
      return Container(
        color: Colors.grey[900],

          height: MediaQuery.of(context).size.height/1.2,


        child: Column(
          children: [
            ListTile(leading: Icon(Icons.favorite_rounded, color: Colors.white54,),
              dense: true,
              title: Text("Like",style: TextStyle(color: Colors.white54),
              ),),
            ListTile(leading: Icon(Icons.comment_rounded, color: Colors.white54,),
              dense: true,
              title: Text("Comment",style: TextStyle(color: Colors.white54),
              ),),
            ListTile(leading: Icon(Icons.share_rounded, color: Colors.white54,),
              dense: true,
              title: Text("Share",style: TextStyle(color: Colors.white54),
              ),),
            ListTile(leading: Icon(Icons.playlist_add, color: Colors.white54,),
              dense: true,
              title: Text("Add to Playlist",style: TextStyle(color: Colors.white54),
              ),),
            ListTile(leading: Icon(Icons.queue_music_rounded, color: Colors.white54,),
              dense: true,
              title: Text("Add to Queue",style: TextStyle(color: Colors.white54),
              ),),
            ListTile(leading: Icon(Icons.person_rounded, color: Colors.white54,),
              dense: true,
              title: Text("View Artist",style: TextStyle(color: Colors.white54),
              ),),
            ListTile(leading: Icon(Icons.album_rounded, color: Colors.white54,),
              dense: true,
              title: Text("View Album",style: TextStyle(color: Colors.white54),
              ),),
            ListTile(leading: Icon(Icons.flag_rounded, color: Colors.white54,),
              dense: true,
              title: Text("Report",style: TextStyle(color: Colors.white54),
              ),),
          ],
        )
      );
    }
    );

  }


    @override
    Widget build(BuildContext context) {
      double sHeight = MediaQuery.of(context).size.height;
      double sWidth = MediaQuery.of(context).size.width;
      return
        SafeArea(
          child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: <Widget>[

                Container // Background
                  (
                  decoration: BoxDecoration(color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1614727187346-ec3a009092b0?ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTV8fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                    ),
                  ),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                ),

                Container //Gradient
                  (
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  decoration: BoxDecoration(
                      color: Colors.white, gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.black12.withOpacity(0.5),
                        Colors.black,
                      ],
                      stops: [0.0, 1.0])),


                ),

                Container
                  (
                  //height: sHeight,

                  //color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: sWidth,
                        child:
                        Row //BackButton
                          (
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(onPressed: () {}, icon:
                            Icon(Icons.keyboard_arrow_down_sharp,
                                color: Colors.white, size: 45),),
                            Padding(
                              padding: EdgeInsets.only(left: sWidth/1.35, top:4),
                              child: IconButton(onPressed: () {}, icon:
                              Icon(Icons.messenger_outline_rounded,
                                  color: Colors.white, size: 32),),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        //color: Colors.red,
                        child:
                        Padding(
                          padding: EdgeInsets.only(top:(sHeight-320)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 17.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text('Space Song', style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),),

                                        //IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_rounded, color: Colors.white)),
                                      ],
                                    ),
                                    Text('BeachHouse', style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AudioFile(advancedPlayer:advancedPlayer),

                      Spacer(),

                      Expanded(
                        child: Container(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              ElevatedButton(onPressed: (){
                                btnMenu();
                              }, child:
                                Icon(Icons.more_horiz_rounded, size: 35,),
                              style: ElevatedButton.styleFrom(shape:new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),primary: Colors.grey[900]))

                            ],

                          ),
                        ),
                      )
                    ],
                  ),

                ),


              ],
            ),
          ),

      ),
        );
    }
  }
