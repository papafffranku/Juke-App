import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lessgoo/abc.dart';

class Pro extends StatefulWidget {
  const Pro({Key? key}) : super(key: key);

  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<Pro> {
  final googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          '${user.displayName} logged in',
          style: TextStyle(color: Colors.blue),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              user.email!,
              style: TextStyle(color: CupertinoColors.white),
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.square_arrow_left),
                    Text('Logout')
                  ],
                ),
                onPressed: () async {await Logout();})
          ],
        ),
      ),
    );
  }

  Future Logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
