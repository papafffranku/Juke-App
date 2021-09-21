import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

class Trail_landing extends StatefulWidget {
  final File UPFcon;
  final String uid;
  final Color background;
  final Color nextColor;

  const Trail_landing({Key? key, required this.UPFcon, required this.uid, required this.background, required this.nextColor})
      : super(key: key);

  @override
  _Trail_landingState createState() => _Trail_landingState();
}

class _Trail_landingState extends State<Trail_landing> {

  @override
  Widget build(BuildContext context) {

    String UID=widget.uid;
    File image=widget.UPFcon;

    return ColorfulSafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(widget.uid),
              Text(widget.UPFcon.path),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.file(
                  File(image.path),
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 300,
                child: Center(
                  child: Text(
                    'title',
                    style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [widget.background, widget.nextColor],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
