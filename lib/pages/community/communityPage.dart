import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
class communityPage extends StatefulWidget {
  const communityPage({Key? key}) : super(key: key);

  @override
  _communityPageState createState() => _communityPageState();
}

class _communityPageState extends State<communityPage> {
  bool expanded = false;
  late List<dynamic> users;
  int count=0;

  @override
  void initState() {
    getUsers();
    // TODO: implement initState
    super.initState();
  }

  getUsers() async {
    final QuerySnapshot snapshot = await usersRef.get();

    setState(() {
      users = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return ColorfulSafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Connect",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              FutureBuilder<QuerySnapshot>(future: usersRef.get(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else{
                      final List username = snapshot.data!.docs.map((doc) => doc['username']).toList();
                      final List picture= snapshot.data!.docs.map((doc) => doc['avatarUrl']).toList();
                      final List email= snapshot.data!.docs.map((doc) => doc['email']).toList();
                      final List songs= snapshot.data!.docs.map((doc) => doc['email']).toList();
                      final List tag= snapshot.data!.docs.map((doc) => doc['songs']).toList();
                      print(username);
                      return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(child: child, scale: animation);
                          },
                          child: Column(
                            children: [
                              Container(
                                key: UniqueKey(),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 475,
                                      width: screenwidth,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(picture[count]))),
                                    ),
                                    Container //Gradient
                                      (
                                      height: 475,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end: FractionalOffset.bottomCenter,
                                              colors: [
                                                Theme.of(context).accentColor.withOpacity(0.2),
                                                Theme.of(context).accentColor,
                                              ],
                                              stops: [
                                                0.5,
                                                1.0
                                              ])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 320.0),
                                      child: Container(
                                        width: screenwidth,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  username[count],
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
                                              tag[count].toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey[400], fontSize: 18),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              "On the lookout for: ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey[400], fontSize: 18),
                                            ),
                                            Text(
                                              "Producers",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 18),
                                            ),
                                            Text(
                                              "Singers",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "View Additional info ",
                                                ),
                                                WidgetSpan(
                                                  child: Icon(CupertinoIcons.forward, size: 18,color: Colors.blue,),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(CupertinoIcons.chat_bubble_2_fill, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      primary: Colors.green, // <-- Button color
                                      onPrimary: Colors.green, // <-- Splash color
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Stack(
                                      children: [
                                        PlayMusic(),
                                        Center(child: Icon(Icons.play_arrow_rounded,color: Theme.of(context).accentColor,))
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if(count==username.length-1){
                                          count=0;
                                        }
                                        else{
                                          count++;
                                          print(count);
                                        }
                                      });
                                    },
                                    child: Icon(CupertinoIcons.shuffle, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      primary: Colors.red, // <-- Button color
                                      onPrimary: Colors.red, // <-- Splash color
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      );
                    }
                  }
              ),

              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(double screenwidth, username, picture, email, song, tag){
    return Stack(
      children: [
        Container(
          height: 475,
          width: screenwidth,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(picture))),
        ),
        Container //Gradient
          (
          height: 475,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Theme.of(context).accentColor.withOpacity(0.2),
                    Theme.of(context).accentColor,
                  ],
                  stops: [
                    0.5,
                    1.0
                  ])),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 320.0),
          child: Container(
            width: screenwidth,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      username,
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
                  tag.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18),
                ),
                SizedBox(height: 15),
                Text(
                  "On the lookout for: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18),
                ),
                Text(
                  "Producers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 18),
                ),
                Text(
                  "Singers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget PlayMusic() {
    return FlareActor(
      'lib/assets/Loading.flr',
      animation: 'Alarm',
      fit: BoxFit.contain,
    );
  }
}
