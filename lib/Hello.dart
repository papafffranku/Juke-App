import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/Reference/Persist.dart';
import 'package:lessgoo/loginsignup/loginwave.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';

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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return Persist();
          } else if (snapshot.hasError) {
            return Scaffold(
                body: Center(
              child: Text('Error'),
            ));
          } else {
            return abc();
          }
        });
  }
}
