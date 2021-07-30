import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/ImageDisplayer.dart';
import 'package:lessgoo/Reference/Persist.dart';
import 'package:lessgoo/loginsignup/NewUserDetail.dart';
import 'package:lessgoo/loginsignup/loginwave.dart';
import 'package:lessgoo/pages/library/library_landing.dart';
import 'package:lessgoo/Hello.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/upload_screen.dart';

final storageRef = FirebaseStorage.instance.ref();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: '/display',
    routes: {
      '/ok': (context) => Hello(),
      '/Pro': (context) => abc(),
      '/upload': (context) => UploadScreen(),
      '/display': (context) => Display(),
      '/library': (context) => LibraryPage(),
      '/persist': (context) => Persist(),
      '/new': (context) => NewDetail(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
