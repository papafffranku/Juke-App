
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/loginsignup/NewUserDetail.dart';

class fireauthhelp{

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
    if(authResult.additionalUserInfo!.isNewUser){
      //new user
      createUserInFirestore1(context);
    }
  }

  Future GoogleLogout() async{
    await googleSignIn.disconnect();
    return _auth.signOut();
  }

  //Create User in Firestore
  createUserInFirestore(BuildContext context) async {
    //check if user exists
    final fyeuser = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot doc = await usersRef.doc(fyeuser.uid).get();

    if(!doc.exists){
      final username = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewDetail()),
      );
      usersRef.doc(fyeuser.uid).set({
        "id": fyeuser.uid,
        "username": username,
        "timestamp" : timestamp
      });
    }
  }

  createUserInFirestore1(BuildContext context) async {
    //check if user exists
    final fyeuser = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot doc = await usersRef.doc(fyeuser.uid).get();

    if(!doc.exists){
      usersRef.doc(fyeuser.uid).set({
        "id": fyeuser.uid,
        "username": fyeuser.displayName,
        "timestamp" : timestamp
      });
    }
  }
}