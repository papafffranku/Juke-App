import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class fireauthhelp {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final usersRef = FirebaseFirestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();

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
    if (authResult.additionalUserInfo!.isNewUser) {
      createUserInFirestore(context);
      String UserName = authResult.user!.displayName.toString();
      Navigator.pushNamed(context, '/anime', arguments: {'UserName': UserName});
    }
  }

  Future GoogleLogout() async {
    await googleSignIn.disconnect();
    return _auth.signOut();
  }

  //Create User in Firestore
  createUserInFirestore(BuildContext context) async {
    final fyeuser = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot doc = await usersRef.doc(fyeuser.uid).get();

    List arr = [false, false, false, false, false];
    if (!doc.exists) {
      usersRef.doc(fyeuser.uid).set({
        "id": fyeuser.uid,
        "username": fyeuser.displayName,
        "avatarUrl":
            'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/template%2FprofilePlaceholder.png?alt=media&token=42a5e4b3-175e-4b59-8aed-52ac8d93f5ae',
        "email": fyeuser.email,
        "bio": '-',
        "tag": arr,
        "lookout": arr,
        "socialfb": '',
        "socialig": '',
        "songs": 0,
        "followers": 0,
        "following": 0,
        "timestamp": timestamp
      });
    }
  }
}
