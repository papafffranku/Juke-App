import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';

class abc extends StatefulWidget {
  const abc({Key? key}) : super(key: key);

  @override
  _abcState createState() => _abcState();
}

class _abcState extends State<abc> {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Column(
          children: [
            CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://i.pinimg.com/originals/a1/46/b8/a146b831d0540717d5ab926760652abd.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ],
                options: CarouselOptions(
                  height: 180,
                  autoPlay: false,
                  autoPlayCurve: Curves.easeInOut,
                  enlargeCenterPage: true,
                  viewportFraction: 0.5,
                )),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(Buttons.Google, onPressed: () {
                    goochapati();
                  }),
                  SignInButton(Buttons.AppleDark, onPressed: () {}),
                  CupertinoButton(
                      child: Text('Sign up with Username and password'),
                      onPressed: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future goochapati() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

}
