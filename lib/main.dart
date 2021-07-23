import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:lessgoo/Hello.dart';
import 'package:lessgoo/abc.dart';
import 'package:lessgoo/firesign/Pro.dart';
=======
import 'package:lessgoo/ImageDisplayer.dart';
import 'package:lessgoo/abc.dart';
import 'package:lessgoo/upload_screen.dart';
>>>>>>> Stashed changes

final storageRef = FirebaseStorage.instance.ref();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    //home: isLoggedIn ? FirstPage() : Persist(),
    initialRoute: '/display',
    routes: {
<<<<<<< Updated upstream
      '/ok':(context) => Hello(),
      '/Pro':(context) => Pro(),
=======
      '/ok': (context) => abc(),
      '/upload': (context) => UploadScreen(),
      '/display': (context) => Display(),
>>>>>>> Stashed changes
    },
    debugShowCheckedModeBanner: false,
  ));
}
