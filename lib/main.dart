import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/ImageDisplayer.dart';
import 'package:lessgoo/Reference/Persist.dart';
import 'package:lessgoo/Reference/anime.dart';
import 'package:lessgoo/loginsignup/NewUserDetail.dart';
import 'package:lessgoo/loginsignup/loginwave.dart';
import 'package:lessgoo/pages/community/communityPage.dart';
import 'package:lessgoo/pages/library/categories/view_album.dart';
import 'package:lessgoo/pages/library/library_landing.dart';
import 'package:lessgoo/Hello.dart';
import 'package:lessgoo/pages/player/player.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:lessgoo/pages/uploadsong/SuccessUpload.dart';

final storageRef = FirebaseStorage.instance.ref();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xff101011),
      backgroundColor: Color(0xff101011),
      accentColor: Color(0xffFFEF00),
      fontFamily: GoogleFonts.lato().fontFamily,
    ),
    initialRoute: '/community',
    routes: {
      '/ok': (context) => Hello(),
      '/Pro': (context) => abc(),
      '/display': (context) => Display(),
      '/library': (context) => LibraryPage(),
      '/persist': (context) => Persist(),
      '/new': (context) => NewDetail(),
      '/player': (context) => MyApp(),
      '/success': (context) => SuccessUpload(),
      '/anime': (context) => anime(),
      '/album': (context) => AlbumViewer(),
      '/profile': (context) => ProfilePage(),
      '/community': (context) => communityPage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
