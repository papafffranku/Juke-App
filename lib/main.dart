import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/Hello.dart';
import 'package:lessgoo/abc.dart';
import 'package:lessgoo/firesign/Pro.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    //home: isLoggedIn ? FirstPage() : Persist(),
    initialRoute: '/ok',
    routes: {
      '/ok':(context) => Hello(),
      '/Pro':(context) => Pro(),
    },
    debugShowCheckedModeBanner: false,
  )
  );
}

