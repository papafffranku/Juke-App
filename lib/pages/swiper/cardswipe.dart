import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class cardSwiper extends StatefulWidget {
  const cardSwiper({Key? key}) : super(key: key);

  @override
  _cardSwiperState createState() => _cardSwiperState();
}

class _cardSwiperState extends State<cardSwiper> {
  bool shuffle = true;

  List<String> names = ['naruto', 'sasuke', 'kakashi','minato'];
  int _count = 0;

  @override
  Widget build(BuildContext context) {

    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;

    return ColorfulSafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: Container(
                  key: UniqueKey(),
                  width: screenWidth*0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white12,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                          NetworkImage("https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/o4meqgw4t4s8yhhp_1613721984.jpeg"),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          names[_count],
                          style: TextStyle(
                              letterSpacing: 1.3,
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Music Producer",style: TextStyle(color: Colors.white54,fontSize: 16),),
                        Text("15 Collabs",style: TextStyle(color: Colors.white54,fontSize: 16),),
                        Text("12 Songs",style: TextStyle(color: Colors.white54,fontSize: 16),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Looking for:",style: TextStyle(color: Colors.white54,fontSize: 16),),
                            Text("Singers",style: TextStyle(color: Colors.white,fontSize: 16),),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                            height: 90,
                            width: 90,
                            child: Stack(
                              children: [
                                FlareActor(
                                  'lib/assets/Loading.flr',
                                  animation: 'Alarm',
                                  fit: BoxFit.contain,
                                ),
                                Center(child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.play_circle_fill,color: Colors.blue,size: 25,))),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(CupertinoIcons.shuffle_thick),
                  onPressed: () {
                    setState(() {
                      if(_count==names.length-1){
                        _count=0;
                      }
                      else{
                        _count += 1;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
