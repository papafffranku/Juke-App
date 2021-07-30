import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/urlgetter.dart';
import 'package:shimmer/shimmer.dart';

class Display extends StatefulWidget {
  final String name;
  const Display({Key? key, required this.name}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  bool singerValue = false;
  bool producerValue = false;
  bool instrumentValue = false;
  bool engineValue = false;
  late List<bool> arr;

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return ColorfulSafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff0e0e15),
          body: Column(
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.green
                ),
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: CupertinoColors.white),
                child: Column(
                  children: [
                    CheckboxListTile(
                        title: Text(
                          'Singer',
                          style: TextStyle(color: Colors.white),
                        ),
                        activeColor: Colors.blue,
                        checkColor: Colors.black,
                        value: singerValue,
                        onChanged: (singerValue) =>
                            setState(() => this.singerValue = singerValue!)),
                    CheckboxListTile(
                        title: Text(
                          'Producer',
                          style: TextStyle(color: Colors.white),
                        ),
                        activeColor: Colors.blue,
                        checkColor: Colors.black,
                        value: producerValue,
                        onChanged: (producerValue) =>
                            setState(() => this.producerValue = producerValue!)),
                    CheckboxListTile(
                        title: Text(
                          'Instrumentalist',
                          style: TextStyle(color: Colors.white),
                        ),
                        activeColor: Colors.blue,
                        checkColor: Colors.black,
                        value: instrumentValue,
                        onChanged: (instrumentValue) =>
                            setState(() => this.instrumentValue = instrumentValue!)),
                    CheckboxListTile(
                        title: Text(
                          'Audio Engineer',
                          style: TextStyle(color: Colors.white),
                        ),
                        activeColor: Colors.blue,
                        checkColor: Colors.black,
                        value: engineValue,
                        onChanged: (engineValue) =>
                            setState(() => this.engineValue = engineValue!)),
                  ],
                ),
              ),
              CupertinoButton(child: Text("Lul"), onPressed: (){getter();})
            ],
          )),
    );
  }
  
  void getter(){
    arr=[singerValue,producerValue,instrumentValue,engineValue];
    print(arr);
  }
  
}
