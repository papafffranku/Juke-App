import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/ImageDisplayer.dart';
import 'package:lessgoo/Reference/Heropop.dart';
import 'package:lessgoo/Reference/Persist.dart';
import 'package:lessgoo/loginsignup/NewUserDetail.dart';
import 'package:lessgoo/loginsignup/loginwave.dart';
import 'package:lessgoo/pages/explore/SearchPage.dart';
import 'package:lessgoo/Hello.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/pages/trails/Trail%20Trial.dart';

import 'package:lessgoo/pages/uploadsong/SuccessUpload.dart';

final storageRef = FirebaseStorage.instance.ref();
final followersRef = FirebaseFirestore.instance.collection('followers');
final followingRef = FirebaseFirestore.instance.collection('following');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff121212),
        backgroundColor: Color(0xff121212),
        accentColor: Color(0xffEFDC6D),
        fontFamily: GoogleFonts.rubik().fontFamily),
    initialRoute: '/ok',
    routes: {
      '/ok': (context) => Hello(),
      '/Pro': (context) => abc(),
      '/display': (context) => Display(),
      '/persist': (context) => Persist(),
      '/new': (context) => NewDetail(),
      '/success': (context) => SuccessUpload(),
      '/profile': (context) => ProfilePage(),
      '/other': (context) => SearchPage(),
      '/hero': (context) => Heropop(),
      '/trailtry': (context) => TextOverImage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
