import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:lessgoo/Firebase%20Auth%20Helper/fireauthservice.dart';
import 'package:lessgoo/loginsignup/UI/wavewidget.dart';
import 'package:shimmer/shimmer.dart';

class abc extends StatefulWidget {
  const abc({Key? key}) : super(key: key);

  @override
  _abcState createState() => _abcState();
}

class _abcState extends State<abc> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final fireauth = fireauthhelp();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xff0e0e15),
        body: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  child: WaveWidget(
                      size: size,
                      yOffset: size.height / 4.5,
                      color: Colors.deepPurple),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            height: 2,
                          ),
                        ),
                        Text(
                          "JVS Music",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          width: double.infinity,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              isRepeatingAnimation: true,
                              animatedTexts: [
                                FadeAnimatedText('Meet'),
                                FadeAnimatedText('Collab'),
                                FadeAnimatedText('Grow'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: height / 3,
                      ),
                      EmailPassFields(),
                      SignInButton(Buttons.Google, onPressed: () async {
                        await fireauth.googleLoginHelp(context);
                      }),
                      SignInButton(Buttons.AppleDark, onPressed: () {}),
                      SizedBox(
                        height: 15,
                      ),
                      newaccount(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget EmailPassFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter Email / Username',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon: Icon(
                CupertinoIcons.mail,
                color: Colors.white54,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: passwordController,
            style: TextStyle(color: Colors.white),
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon: Icon(
                CupertinoIcons.lock,
                color: Colors.white54,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(), primary: Colors.white),
            child: Icon(
              CupertinoIcons.arrow_right,color: Colors.purple,
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget newaccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No Account yet?',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        InkWell(
          onTap: (){
            print('new acc');
          },
          child: Text(
            ' Sign-Up here',
            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
