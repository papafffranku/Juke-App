import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/uploadsong/ModalScreens.dart';
import 'package:lessgoo/pages/uploadsong/SuccessUpload.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class prefs extends StatefulWidget {
  const prefs({Key? key}) : super(key: key);

  @override
  _prefsState createState() => _prefsState();
}

class _prefsState extends State<prefs> {
  final modal = ModalScreens();
  int c1 = 0;
  final usersRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setter();
  }

  @override
  Widget build(BuildContext context) {
    final query =
        usersRef.orderBy('timestamp', descending: true).limit(4).snapshots();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }

  setter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0);
    setState(() {
      c1 = counter;
    });
  }
}
