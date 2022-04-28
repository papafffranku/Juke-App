import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class nousers extends StatefulWidget {
  const nousers({Key? key}) : super(key: key);

  @override
  _nousersState createState() => _nousersState();
}

class _nousersState extends State<nousers> {
  bool move = false;
  Widget nouser1() {
    return Center(
        child: Column(
      children: [
        Text(
          'Sorry',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Thats all the users we had for you today, share the app with others to to help us build a thriving community",
          style: TextStyle(fontSize: 18),
          maxLines: 3,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'Grow the community',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'This app is only as great as the people in it. So, go ahead and share this app with your friends.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        ElevatedButton.icon(
          label: Text("Share"),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () {},
          icon: Icon(Icons.share),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: (){

                },
                child: FadeIn(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceIn,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff161616),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.005, 0.995],
                            colors: [Color(0xff222222), Colors.black]),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 2,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'See new users',
                                style: TextStyle(fontSize: 20,color: Theme.of(context).accentColor),
                              ),
                              WidgetSpan(
                                child: Icon(CupertinoIcons.forward,color: Theme.of(context).accentColor,size: 19,),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Make them feel welcome',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      ' Connect',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FadeIn(
                child: nouser1(),
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  move=!move;
                });
              },
              child: Container(
                height: 200,
                width: 200,
                color: Colors.red,
                child: Stack(
                  children: [
                    Positioned(
                        top:90,
                        left: 50,
                        child: Text(
                      'data',
                      style: TextStyle(color: Colors.blue),
                    )),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 250),
                      top:move ? 40 : 80,
                      left: 50,
                      child: Container(
                        width: 100,
                        height: 40,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
