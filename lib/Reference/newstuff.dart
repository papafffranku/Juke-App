import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class newstuff extends StatefulWidget {
  const newstuff({Key? key}) : super(key: key);

  @override
  _newstuffState createState() => _newstuffState();
}

class _newstuffState extends State<newstuff> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width=size.width;
    double height=size.height;

    return ColorfulSafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Stack(
                  children: [
                    Container(
                      height: 0.4*width,
                      width: 0.4*width,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/Bandppl.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: 0.4*width,
                      width: 0.4*width,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        gradient: RadialGradient(
                          center: Alignment(-0.8, 0.8),
                          colors: [
                            Colors.blue,
                            Colors.transparent
                          ],
                          radius: 2.4,
                          stops: [0.005, 0.995],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.25*width,left: 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'New Artists',
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                            ),
                            WidgetSpan(
                              child: Icon(CupertinoIcons.forward,color: Theme.of(context).accentColor,size: 22,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.32*width,left: 5),
                      child: Text('See the newbies',style: TextStyle(color: Colors.white70),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Stack(
                  children: [
                    Container(
                      height: 0.4*width,
                      width: 0.4*width,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/records.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: 0.4*width,
                      width: 0.4*width,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        gradient: RadialGradient(
                          center: Alignment(-0.8, 0.8),
                          colors: [
                            Colors.blue,
                            Colors.transparent
                          ],
                          radius: 2.4,
                          stops: [0.005, 0.995],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.25*width,left: 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'New Songs',
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                            ),
                            WidgetSpan(
                              child: Icon(CupertinoIcons.forward,color: Theme.of(context).accentColor,size: 22,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.32*width,left: 5),
                      child: Text('New tracks',style: TextStyle(color: Colors.white70),),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
