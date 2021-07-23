import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/abc.dart';
import 'package:lessgoo/firesign/Pro.dart';

class Hello extends StatefulWidget {
  const Hello({Key? key}) : super(key: key);

  @override
  _HelloState createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          } else if(snapshot.hasData){
            return Pro();
          } else if(snapshot.hasError){
            return Scaffold(body: Center(child: Text('Error bro'),));
          } else{
            return abc();
          }
        }
    );
  }
}
