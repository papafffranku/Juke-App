import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class prefs extends StatefulWidget {
  const prefs({Key? key}) : super(key: key);

  @override
  _prefsState createState() => _prefsState();
}

class _prefsState extends State<prefs> {
  int c1=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          CupertinoButton(child: Text('increment'), onPressed: (){_incrementCounter();}),
          Text(c1.toString())
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
      c1=counter;
    });
  }
}
