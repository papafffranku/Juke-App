import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class anime extends StatefulWidget {
  const anime({Key? key}) : super(key: key);

  @override
  _animeState createState() => _animeState();
}

class _animeState extends State<anime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NavBar"),
        centerTitle: true,
      ),
    );
  }
}
