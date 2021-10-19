import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/ImageDisplayer.dart';
import 'package:lessgoo/Reference/Heropop.dart';
import 'package:lessgoo/Reference/Persist.dart';
import 'package:lessgoo/loginsignup/NewUserDetail.dart';
import 'package:lessgoo/loginsignup/loginwave.dart';
import 'package:lessgoo/pages/channel/channels.dart';
import 'package:lessgoo/pages/chat/chat_landing.dart';
import 'package:lessgoo/Hello.dart';

import 'package:lessgoo/pages/trails/Trail%20Trial.dart';

import 'package:lessgoo/pages/uploadsong/SuccessUpload.dart';

import 'Reference/anime.dart';

final storageRef = FirebaseStorage.instance.ref();
final followersRef = FirebaseFirestore.instance.collection('followers');
final followingRef = FirebaseFirestore.instance.collection('following');
final userRef = FirebaseFirestore.instance.collection('users');
final chatroomRef = FirebaseFirestore.instance.collection('chatroom');
final usertileRef = FirebaseFirestore.instance.collection('userstile');
final tracksRef = FirebaseFirestore.instance.collection('tracks');
final likesRef = FirebaseFirestore.instance.collection('likes');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
final activityfeedRef = FirebaseFirestore.instance.collection('activityfeed');
final audioPlayer = AudioPlayer();
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
      '/other': (context) => ChannelPage(),
      '/hero': (context) => Heropop(),
      '/trailtry': (context) => TextOverImage(),
      '/chat': (context) => ChatLanding(),
      '/channel': (context) => ChannelPage(),
      '/anime': (context) => anime(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
