import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatefulWidget {
  final data;

  const EditProfile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late List<bool> arr;

  final usersRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    TagData();
    super.initState();
  }

  bool boolcheck(arr123) {
    if (arr123 == 'true') {
      return true;
    } else {
      return false;
    }
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
  bool coverValue = false;

  String? profile;
  bool profileStatus = false;

  File? Cover;
  String path = '';
  FilePickerResult? result;
  late PlatformFile file;

  void TagData() {
    List arr123 = widget.data['tag'];

    setState(() {
      singerValue = boolcheck(arr123[0].toString());
      producerValue = boolcheck(arr123[1].toString());
      instrumentValue = boolcheck(arr123[2].toString());
      engineValue = boolcheck(arr123[3].toString());
      coverValue = boolcheck(arr123[4].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    UsernameControl.text = widget.data['username'];
    BioControl.text = widget.data['bio'];
    InstagramControl.text = widget.data['socialig'];
    FacebookControl.text = widget.data['socialfb'];

    profile = widget.data['avatarUrl'];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Edit Profile',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CupertinoButton(
              onPressed: () async {
                if (path != '') {
                  await Uploader(widget.data['id'], Cover!);
                }
                await WriteDetails();
                Navigator.pop(context);
              },
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        if (path == '') ...[
                          GestureDetector(
                            onTap: () async {
                              Cover = await CoverArtSelecter();
                              setState(() {
                                path = Cover!.path.toString();
                              });
                            },
                            child: CircleAvatar(
                              radius: 45.0,
                              backgroundImage: NetworkImage(profile!),
                              backgroundColor: Colors.transparent,
                            ),
                          )
                        ] else ...[
                          GestureDetector(
                            onTap: () async {
                              Cover = await CoverArtSelecter();
                              setState(() {
                                path = Cover!.path.toString();
                              });
                            },
                            child: CircleAvatar(
                              radius: 45.0,
                              backgroundImage: FileImage(
                                File(path),
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 200,
                    child: Column(
                      children: [
                        TextField(
                          controller: UsernameControl,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              hintText: "Shown on your profile page",
                              hintStyle: TextStyle(color: Colors.grey[700]),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                              )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                              ))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "About You",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: BioControl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            hintText: "Tell others a little bit about yourself",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      "Your skills",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Theme(
                    data:
                        ThemeData(unselectedWidgetColor: CupertinoColors.white),
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
                            onChanged: (singerValue) => setState(
                                () => this.singerValue = singerValue!)),
                        CheckboxListTile(
                            title: Text(
                              'Producer',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: producerValue,
                            onChanged: (producerValue) => setState(
                                () => this.producerValue = producerValue!)),
                        CheckboxListTile(
                            title: Text(
                              'Instrumentalist',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: instrumentValue,
                            onChanged: (instrumentValue) => setState(
                                () => this.instrumentValue = instrumentValue!)),
                        CheckboxListTile(
                            title: Text(
                              'Audio Engineer',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: engineValue,
                            onChanged: (engineValue) => setState(
                                () => this.engineValue = engineValue!)),
                        CheckboxListTile(
                            title: Text(
                              'Cover Artist',
                              style: TextStyle(color: Colors.white),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            value: coverValue,
                            onChanged: (coverValue) =>
                                setState(() => this.coverValue = coverValue!)),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      "Social Links",
                      style: TextStyle(color: Colors.grey[400], fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
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
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          hintText: 'Instagram',
                          hintStyle: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
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
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          hintText: 'Facebook',
                          hintStyle: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
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
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          hintText: 'Other',
                          hintStyle: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  CupertinoButton(
                      child: Text('value'),
                      onPressed: () {
                        tagProcess();
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Uploader(String uid, File Cover) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('profilePic/$uid')
          .putFile(Cover);
    } catch (e) {
      print(e);
    }
    String DPLink = await getUrl('profilePic/$uid');
    usersRef.doc(widget.data['id']).update({
      "avatarUrl": DPLink.toString(),
    });
  }

  Future<String> getUrl(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(s);
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<void> WriteDetails() async {
    arr = [
      singerValue,
      producerValue,
      instrumentValue,
      engineValue,
      coverValue
    ];
    usersRef.doc(widget.data['id']).update({
      "username": UsernameControl.text,
      "bio": BioControl.text,
      "tag": arr,
      "socialfb": FacebookControl.text,
      "socialig": InstagramControl.text,
    });
  }

  Future<File> CoverArtSelecter() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    file = result!.files.first;
    return (File(file.path.toString()));
  }

  void tagProcess() {
    arr = [
      singerValue,
      producerValue,
      instrumentValue,
      engineValue,
      coverValue
    ];
    print(arr);
    String tagger = '';
    print(arr.length);
    for (int i = 0; i <= arr.length - 1; i++) {
      if (arr[i] == true) {
        if (i == 0) {
          tagger = ' Singer ';
          print(tagger.toString());
        } else if (i == 1) {
          tagger = tagger + ' Producer ';
        } else if (i == 2) {
          tagger = tagger + ' Instrumentalist ';
        } else if (i == 3) {
          tagger = tagger + ' Audio Engineer ';
        } else if (i == 4) {
          tagger = tagger + ' Cover Artist ';
        }
      }
    }
    print(tagger);
  }
}
