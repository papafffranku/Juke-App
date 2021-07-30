import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/urlgetter.dart';
import 'package:shimmer/shimmer.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    double screenheight=MediaQuery. of(context). size. height;
    double screenwidth=MediaQuery. of(context). size. width;

    return ColorfulSafeArea(
      child: Scaffold(
        backgroundColor:Color(0xff0e0e15),
        body: Column(
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: CupertinoColors.white),
              child: CheckboxListTile(
                title: Text('Singer',style: TextStyle(
                  color: Colors.white
                ),),
                  activeColor: Colors.blue,
                  checkColor: Colors.black,
                  value: value,
                  onChanged: (value)=>
                      setState(()=>this.value = value!)
              ),
            )
          ],
        )
      ),
    );
  }
}
