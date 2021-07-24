import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:lessgoo/Firebase%20Auth%20Helper/fireauthservice.dart';
import 'package:lessgoo/loginsignup/UI/wavewidget.dart';

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
        backgroundColor: Color(0xff0e0e15),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOutQuad,
                    child: WaveWidget(
                        size: size,
                        yOffset: size.height / 6,
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
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 3 - 60),
                    child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Meet Collaborators and help each other grow',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Icon(CupertinoIcons.graph_circle,color: Colors.white,)
                          ],
                        )),
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
                          await fireauth.googleLoginHelp();
                        }),
                        SignInButton(Buttons.Apple, onPressed: () {}),
                        newaccount(),
                      ],
                    ),
                  ),
                ],
              ),
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
                color: Colors.white38,
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
                CupertinoIcons.mail_solid,
                color: Colors.white38,
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
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
                color: Colors.white38,
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
                CupertinoIcons.lock_circle_fill,
                color: Colors.white38,
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(), primary: Colors.blue),
            child: Icon(
              CupertinoIcons.arrow_right,
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'or',
            style: TextStyle(color: Colors.white, fontSize: 18),
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
        CupertinoButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign-Up now',
                ),
                Icon(CupertinoIcons.forward),
              ],
            ),
            onPressed: () {})
      ],
    );
  }
}
