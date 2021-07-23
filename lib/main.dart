import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/abc.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  await Firebase.initializeApp();

  runApp(MaterialApp(
    //home: isLoggedIn ? FirstPage() : Persist(),
    initialRoute: '/ok',
    routes: {
      '/ok':(context) => abc(),
    },
    debugShowCheckedModeBanner: false,
  )
  );
}

