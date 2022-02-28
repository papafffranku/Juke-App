import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/main.dart';

class fireauthhelp {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final usersRef = FirebaseFirestore.instance.collection('users');
  final total = FirebaseFirestore.instance.collection('totalusers');

  //google auth
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLoginHelp(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var authResult = await _auth.signInWithCredential(credential);
    _saveDeviceToken();
    if (authResult.additionalUserInfo!.isNewUser) {
      createUserInFirestore(context);
      await Navigator.pushNamed(context, '/onboard');
    }
  }

  Future GoogleLogout() async {
    await googleSignIn.disconnect();
    return _auth.signOut();
  }

  _saveDeviceToken() async {
    final fyeuser = FirebaseAuth.instance.currentUser!;
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      var tokenRef =
          userRef.doc(fyeuser.uid).collection('tokens').doc(fcmToken);

      await tokenRef.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> indexer1(String uid1) async {
    for(int i=0;i<=10;i++){
      int otp = new Random().nextInt(10);
      print(otp);
      await usersRef.doc(uid1).update({"indexer.$i": otp});
    }
  }

  //Create User in Firestore
  createUserInFirestore(BuildContext context) async {
    final fyeuser = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot doc = await usersRef.doc(fyeuser.uid).get();
    DateTime timestamp = DateTime.now();
    DateTime past = timestamp.subtract(new Duration(days: 2));
    String number='0';

    await total.doc('totalnumber').get().then((value) async {
      var fields = value.data();
      number = (fields!['number']).toString();
    });


    if (!doc.exists) {

      usersRef.doc(fyeuser.uid).set({
        "id": fyeuser.uid,
        "username": fyeuser.displayName,
        "avatarUrl":
            'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/template%2FprofilePlaceholder.png?alt=media&token=42a5e4b3-175e-4b59-8aed-52ac8d93f5ae',
        "email": fyeuser.email,
        "bio": 'No bio',
        "tag": [false, false, false, false, false],
        "lookout": [false, false, false, false, false],
        "socialfb": '',
        "socialig": '',
        "songs": 0,
        "followers": 0,
        "following": 0,
        "timestamp": timestamp,
        "swipe": past,
        "connectNumber": int.parse(number),
        "featured": 'no',
        "stringTag": ['nothing selected'],
        "indexer": [1,2,3],
        "random": new Random().nextInt(10),
      });

      await indexer1(fyeuser.uid);

      // _saveDeviceToken();

      total.doc('totalnumber').update({
        "number": FieldValue.increment(1),
      });
    }
  }
}
