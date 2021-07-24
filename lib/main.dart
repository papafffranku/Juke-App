import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/ref/Hello.dart';
import 'package:lessgoo/Firebase%20Auth%20Helper/Pro.dart';
import 'package:lessgoo/ImageDisplayer.dart';
import 'package:lessgoo/upload_screen.dart';

final storageRef = FirebaseStorage.instance.ref();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    //home: isLoggedIn ? FirstPage() : Persist(),
    initialRoute: '/display',
    routes: {
      '/ok':(context) => Hello(),
      '/Pro':(context) => Pro(),
      '/upload': (context) => UploadScreen(),
      '/display': (context) => Display(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
