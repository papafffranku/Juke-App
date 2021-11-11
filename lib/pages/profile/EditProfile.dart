import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lessgoo/PopUp/CustomRectTween.dart';
import 'package:lessgoo/PopUp/HeroDialogRoute.dart';

class EditProfile extends StatefulWidget {
  final data;

  const EditProfile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

const String _heroAddTodo = 'add-todo-hero';
const String _heroAddTodo2 = 'add-todo-hero2';

class _EditProfileState extends State<EditProfile> {
  late List<bool> arr;

  String page1 = "none";
  String page2 = "none";
  List boolarr1 = [];
  List boolarr2 = [];

  final usersRef = FirebaseFirestore.instance.collection('users');
  final banner = FirebaseFirestore.instance.collection('banner');

  @override
  void initState() {
    super.initState();
    page1=tagProcess(widget.data['tag']);
    page2=tagProcess(widget.data['lookout']);
    boolarr1=widget.data['tag'];
    boolarr2=widget.data['lookout'];
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
                              style: TextStyle(color: Colors.white, fontSize: 20)),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text('Your Skills',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Hero(
                  tag: _heroAddTodo,
                  createRectTween: (begin, end) {
                    return CustomRectTween(begin: begin, end: end);
                  },
                  child: Material(
                    color: Colors.black,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      tileColor: Color(0xffEFDC6D),
                      title: Text(
                        page1,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      trailing: Icon(
                        CupertinoIcons.forward,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final List result = await Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          List tagarr=widget.data['tag'];
                          return _AddTodoPopupCard(tagarr: tagarr,);
                        }));
                        boolarr1 = result;
                        print (boolarr1);
                        if (result.toString() != 'null') {
                          setState(() {
                            //page1 = result.toString();
                            page1 = tagProcess(result);
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text('On the lookout for',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Hero(
                  tag: _heroAddTodo2,
                  createRectTween: (begin, end) {
                    return CustomRectTween(begin: begin, end: end);
                  },
                  child: Material(
                    color: Colors.black,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      tileColor: Color(0xffEFDC6D),
                      title: Text(
                        page2,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      trailing: Icon(
                        CupertinoIcons.forward,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final List result = await Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          List tagarr=widget.data['tag'];
                          return _AddTodoPopupCard2(tagarr: tagarr,);
                        }));
                        boolarr2 = result;
                        print (boolarr2);
                        if (result.toString() != 'null') {
                          setState(() {
                            //page1 = result.toString();
                            page2 = tagProcess(result);
                          });
                        }
                      },
                    ),
                  ),
                ),
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
                        style: TextStyle(color: Colors.white, fontSize: 20)),
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
    banner.doc(widget.data['id']).update({
      "avatarUrl": DPLink.toString(),
    });
  }

  Future<String> getUrl(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(s);
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<void> WriteDetails() async {
    arr = [singerValue, producerValue, instrumentValue, engineValue, coverValue];
    usersRef.doc(widget.data['id']).update({
      "username": UsernameControl.text,
      "bio": BioControl.text,
      "tag": boolarr1,
      "lookout":boolarr2,
      "socialfb": FacebookControl.text,
      "socialig": InstagramControl.text,
    });
    banner.doc(widget.data['id']).update({
      "username": UsernameControl.text
    });
  }

  Future<File> CoverArtSelecter() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    file = result!.files.first;
    return (File(file.path.toString()));
  }

  String tagProcess(arr) {
    String tagger = '';
    print(arr.length);
    for (int i = 0; i <= arr.length - 1; i++) {
      if (arr[i].toString() == 'true') {
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
    return (tagger);
  }

}

//popups

class _AddTodoPopupCard extends StatefulWidget {
  final tagarr;
  const _AddTodoPopupCard({Key? key, this.tagarr}) : super(key: key);

  @override
  State<_AddTodoPopupCard> createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<_AddTodoPopupCard> {
  bool singerValue = false;
  bool producerValue = false;
  bool instrumentValue = false;
  bool engineValue = false;
  bool coverValue = false;

  @override
  void initState() {
    super.initState();
    singerValue=widget.tagarr[0];
    producerValue=widget.tagarr[1];
    instrumentValue=widget.tagarr[2];
    engineValue=widget.tagarr[3];
    coverValue=widget.tagarr[4];
  }

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Theme.of(context).colorScheme.secondary,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                          unselectedWidgetColor: CupertinoColors.black),
                      child: Column(
                        children: [
                          CheckboxListTile(
                              title: Text(
                                'Singer',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: singerValue,
                              onChanged: (singerValue) => setState(
                                      () => this.singerValue = singerValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Producer',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: producerValue,
                              onChanged: (producerValue) => setState(
                                      () => this.producerValue = producerValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Instrumentalist',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: instrumentValue,
                              onChanged: (instrumentValue) => setState(() =>
                              this.instrumentValue = instrumentValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Audio Engineer',
                                style: TextStyle(color: Colors.black),
                              ),
                              selectedTileColor: Colors.black,
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: engineValue,
                              onChanged: (engineValue) => setState(
                                      () => this.engineValue = engineValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Cover Artist',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: coverValue,
                              onChanged: (coverValue) => setState(
                                      () => this.coverValue = coverValue!)),
                          CupertinoButton(
                            onPressed: () {
                              List skills = [
                                singerValue,
                                producerValue,
                                instrumentValue,
                                engineValue,
                                coverValue
                              ];
                              Navigator.pop(context, skills);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddTodoPopupCard2 extends StatefulWidget {
  final tagarr;
  const _AddTodoPopupCard2({Key? key, this.tagarr}) : super(key: key);

  @override
  State<_AddTodoPopupCard2> createState() => _AddTodoPopupCardState2();
}

class _AddTodoPopupCardState2 extends State<_AddTodoPopupCard2> {
  bool singerValue = false;
  bool producerValue = false;
  bool instrumentValue = false;
  bool engineValue = false;
  bool coverValue = false;

  @override
  void initState() {
    super.initState();
    singerValue=widget.tagarr[0];
    producerValue=widget.tagarr[1];
    instrumentValue=widget.tagarr[2];
    engineValue=widget.tagarr[3];
    coverValue=widget.tagarr[4];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo2,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Theme.of(context).colorScheme.secondary,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                          unselectedWidgetColor: CupertinoColors.black),
                      child: Column(
                        children: [
                          CheckboxListTile(
                              title: Text(
                                'Singer',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: singerValue,
                              onChanged: (singerValue) => setState(
                                      () => this.singerValue = singerValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Producer',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: producerValue,
                              onChanged: (producerValue) => setState(
                                      () => this.producerValue = producerValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Instrumentalist',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: instrumentValue,
                              onChanged: (instrumentValue) => setState(() =>
                              this.instrumentValue = instrumentValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Audio Engineer',
                                style: TextStyle(color: Colors.black),
                              ),
                              selectedTileColor: Colors.black,
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: engineValue,
                              onChanged: (engineValue) => setState(
                                      () => this.engineValue = engineValue!)),
                          CheckboxListTile(
                              title: Text(
                                'Cover Artist',
                                style: TextStyle(color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              checkColor:
                              Theme.of(context).colorScheme.secondary,
                              value: coverValue,
                              onChanged: (coverValue) => setState(
                                      () => this.coverValue = coverValue!)),
                          CupertinoButton(
                            onPressed: () {
                              List skills = [
                                singerValue,
                                producerValue,
                                instrumentValue,
                                engineValue,
                                coverValue
                              ];
                              Navigator.pop(context, skills);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
