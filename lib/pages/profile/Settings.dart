import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0e0e15),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Settings",style: TextStyle(fontSize: 25),),
      ),
      backgroundColor: Color(0xff0e0e15),
      body: ColorfulSafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Text("Account",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),),
                        ],
                      ),
                    ),
                    Holders('Account details','View your account details',CupertinoIcons.person_alt_circle_fill),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Text("Guide",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),),
                        ],
                      ),
                    ),
                    Holders('Guide','Utilize all of our features',CupertinoIcons.doc_fill),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Text("Notifications",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),),
                        ],
                      ),
                    ),
                    Holders('Notifications','Configure Notification Settings',CupertinoIcons.bell_fill),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Text("Feedback and Help",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),),
                        ],
                      ),
                    ),
                    Holders('Support','Get help from us',Icons.contact_support_rounded),
                    Holders('Connect with us','Feedback or Features you want',Icons.feedback_rounded),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Text("Storage",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),),
                        ],
                      ),
                    ),
                    Holders('Clear Cache','Delete data stored in cache',CupertinoIcons.delete_solid),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text("About",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),),
                        ],
                      ),
                    ),
                    ListTile(
                      dense: true,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(CupertinoIcons.info_circle_fill,color: Colors.white,size: 35,),
                        ],
                      ),
                      title: Text('Version',textScaleFactor: 1.25,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                      subtitle: Text('1.0.0.1',style: TextStyle(color: Colors.white54),),
                      tileColor: Color(0xff0e0e15),
                    ),
                    Holders('Third-party software','Packages and software that helped us',CupertinoIcons.doc_plaintext),
                    Holders('Privacy and Security','Know how your data is kept safe',CupertinoIcons.lock_circle_fill),
                    Holders('Community Guidelines',"What's allowed and whats not",Icons.rule_sharp),
                  ],
                )
              ),
              SizedBox(height: 30,),
              CupertinoButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.square_arrow_left),
                      Text('Logout')
                    ],
                  ),
                  onPressed: () async {await Logout();}),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Widget Holders(String title1, String sub1, IconData icon1){
    return ListTile(
      dense: true,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon1,color: Colors.white,size: 35,),
        ],
      ),
      title: Text(title1,textScaleFactor: 1.25,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
      trailing: Icon(Icons.arrow_forward_ios,color: CupertinoColors.systemBlue,),
      subtitle: Text(sub1,style: TextStyle(color: Colors.white54),),
      tileColor: Color(0xff0e0e15),
    );
  }

  Future Logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
