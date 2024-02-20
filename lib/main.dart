import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/ImageDisplayer.dart';
import 'package:lessgoo/Reference/Heropop.dart';
import 'package:lessgoo/Reference/Persist.dart';
import 'package:lessgoo/Reference/newstuff.dart';
import 'package:lessgoo/Reference/prefs.dart';
import 'package:lessgoo/Reference/timer.dart';
import 'package:lessgoo/loginsignup/NewUserDetail.dart';
import 'package:lessgoo/loginsignup/loginwave.dart';
import 'package:lessgoo/methods/database.dart';
import 'package:lessgoo/pages/channel/channels.dart';
import 'package:lessgoo/pages/chat/chat_landing.dart';
import 'package:lessgoo/Hello.dart';
import 'package:lessgoo/pages/connect/Konnect.dart';
import 'package:lessgoo/pages/connect/connectPage.dart';
import 'package:lessgoo/pages/connect/design.dart';
import 'package:lessgoo/pages/connect/finalist.dart';
import 'package:lessgoo/pages/connect/noswipes.dart';
import 'package:lessgoo/pages/connect/nousers.dart';
import 'package:lessgoo/pages/connect/ope.dart';
import 'package:lessgoo/pages/profile/ProfileLanding.dart';

import 'package:lessgoo/pages/trails/Trail%20Trial.dart';

import 'package:lessgoo/pages/uploadsong/SuccessUpload.dart';
import 'package:provider/provider.dart';

import 'Reference/onboard.dart';

final storageRef = FirebaseStorage.instance.ref();
final followersRef = FirebaseFirestore.instance.collection('followers');
final followingRef = FirebaseFirestore.instance.collection('following');
final userRef = FirebaseFirestore.instance.collection('users');
final chatroomRef = FirebaseFirestore.instance.collection('chatroom');
final tracksRef = FirebaseFirestore.instance.collection('tracks');
final likesRef = FirebaseFirestore.instance.collection('likes');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
final activityfeedRef = FirebaseFirestore.instance.collection('activityfeed');
final userbannerRef = FirebaseFirestore.instance.collection('banner');
final libraryRef = FirebaseFirestore.instance.collection('library');
final audioPlayer = AudioPlayer();

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Background message');
  print(message.notification!.title);
  print(message.notification!.body);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
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
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(1)),
        brightness: Brightness.dark,
        primaryColor: Color(0xff121212),
        backgroundColor: Color(0xff121212),
        hintColor: Color(0xffEFDC6D), //accent color is now hint color
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
      '/profile': (context) => ProfileLanding(),
      '/onboard': (context) => onboard(),
      '/connect': (context) => ConnectPage(),
      '/prefs': (context) => prefs(),
      '/time': (context) => time123(),
      '/nos': (context) => noswipes(
            time1: '123',
            timedate: DateTime.now(),
          ),
      '/nouser': (context) => nousers(),
      '/newstuff': (context) => newstuff(),
      '/K': (context) => konnect(),
      '/ope': (context) => ope(),
      '/finalist': (context) => finalist(),
      '/d': (context) => Design(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
