import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:lessgoo/firesign/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';

class abc extends StatefulWidget {
  const abc({Key? key}) : super(key: key);

  @override
  _abcState createState() => _abcState();
}

class _abcState extends State<abc> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white12,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton(
                    Buttons.Google,
                    onPressed: (){
                      final provider =
                        Provider.of<GoogleSignInProvider>(context,listen: false);
                      provider.googleLogin();

                    }),
                SignInButton(
                    Buttons.AppleDark,
                    onPressed: (){

                    }),
                CupertinoButton(child: Text('Sign up with Username and password'), onPressed: (){})
              ],
            ),
          ),
        ),
      ),
  );

  Future goochapati()async{

  }
}
