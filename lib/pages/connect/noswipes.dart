import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class noswipes extends StatefulWidget {
  final String time1;
  final DateTime timedate;
  const noswipes({Key? key, required this.time1, required this.timedate})
      : super(key: key);

  @override
  _noswipesState createState() => _noswipesState();
}

final usersRef = FirebaseFirestore.instance.collection('users');
final total = FirebaseFirestore.instance.collection('totalusers');
final uid = FirebaseAuth.instance.currentUser!.uid;

class _noswipesState extends State<noswipes> {
  late DateTime lastTime;
  late bool check;

  bool connect(DateTime lastTime) {
    DateTime timestamp = DateTime.now();
    if (timestamp.isBefore(lastTime)) {
      return false;
    } else {
      return true;
    }
  }

  Widget outofswipes(String time) {
    return Center(
        child: Column(
      children: [
        Text(
          'Yikes!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "looks like you're all out of shuffles",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "unlocks next at: ",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              time,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          label: Text("Refresh"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () {
            if (connect(lastTime) == true) {
              Navigator.pop(context);
            } else {
              Snackbar('Your swipes will unlock at $time');
            }
          },
          icon: Icon(CupertinoIcons.refresh),
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
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
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
            FadeIn(
              child: outofswipes(widget.time1),
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
            ),
          ],
        ),
      ),
    );
  }

  void Snackbar(String abc) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        abc,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Color(0xff24B8D6),
    ));
  }
}
