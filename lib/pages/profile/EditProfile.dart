
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EditProfile extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditProfile({Key? key, required this.data,}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String Background='https://images.unsplash.com/photo-1579546929662-711aa81148cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80';
  String Profile = 'https://www.classifapp.com/wp-content/uploads/2017/09/avatar-placeholder.png';
  late List<bool> arr;

  final usersRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }


  //controllers
  final TextEditingController UsernameControl = TextEditingController();
  final TextEditingController BioControl = TextEditingController();
  final TextEditingController InstagramControl = TextEditingController();
  final TextEditingController FacebookControl = TextEditingController();
  final TextEditingController OtherControl = TextEditingController();

  bool singerValue = false;
  bool producerValue = false;
  bool instrumentValue = false;
  bool engineValue = false;

  @override
  Widget build(BuildContext context) {

    UsernameControl.text=widget.data['username'];
    BioControl.text=widget.data['bio'];
    InstagramControl.text=widget.data['socialig'];
    FacebookControl.text=widget.data['socialfb'];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Edit Profile',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25
            )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CupertinoButton(
              onPressed: () async {
                await WriteDetails();
              },
              child: Text("Save",
              style: TextStyle(
                fontSize: 18
              ),),
            ),
          ),
        ], //<Widget>[]
        backgroundColor: Colors.black,
        elevation: 50.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        image:DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(Background)
                        )
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0,left: 8),
                        child: CircleAvatar(
                          radius: 45.0,
                          backgroundImage:
                          NetworkImage(Profile),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Username",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16
                            ),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: UsernameControl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            hintText: "Shown on your profile page",
                            hintStyle: TextStyle(
                                color: Colors.grey[700]
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("About You",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16
                            ),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: BioControl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Tell others a little bit about yourself",
                            hintStyle: TextStyle(
                              color: Colors.grey[700]
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text("Your skills",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),),
                    Icon(CupertinoIcons.forward,color: Colors.white,)
                  ],
                ),
              ),
              Column(
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: CupertinoColors.white),
                    child: Column(
                      children: [
                        CheckboxListTile(
                            title: Text(
                              'Singer',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: singerValue,
                            onChanged: (singerValue) =>
                                setState(() => this.singerValue = singerValue!)),
                        CheckboxListTile(
                            title: Text(
                              'Producer',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: producerValue,
                            onChanged: (producerValue) =>
                                setState(() => this.producerValue = producerValue!)),
                        CheckboxListTile(
                            title: Text(
                              'Instrumentalist',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: instrumentValue,
                            onChanged: (instrumentValue) =>
                                setState(() => this.instrumentValue = instrumentValue!)),
                        CheckboxListTile(
                            title: Text(
                              'Audio Engineer',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: engineValue,
                            onChanged: (engineValue) =>
                                setState(() => this.engineValue = engineValue!)),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text("Social Links",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16
                    ),),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery. of(context). size. width-10,
                          child: TextField(
                            controller: InstagramControl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              hintText: 'Instagram',
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery. of(context). size. width-10,
                          child: TextField(
                            controller: FacebookControl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              hintText: 'Facebook',
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery. of(context). size. width-10,
                          child: TextField(
                            controller: OtherControl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              hintText: 'Other',
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //get tags
  void tagGet(){
    arr=[singerValue,producerValue,instrumentValue,engineValue];
    print(arr);
  }

  Future<void> WriteDetails() async {
    usersRef.doc(widget.data['id']).update({
      "username": UsernameControl.text,
      "avatarUrl": 'https://firebasestorage.googleapis.com/v0/b/jvsnew-93e01.appspot.com/o/template%2Fprofile.png?alt=media&token=bb19b87c-2af3-4e5e-bf40-3f757cd99053',
      "bio": BioControl.text,
      "tag": '',
      "socialfb": FacebookControl.text,
      "socialig": InstagramControl.text,
    });
  }
}
