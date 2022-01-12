import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lessgoo/PopUp/CustomRectTween.dart';
import 'package:lessgoo/PopUp/HeroDialogRoute.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';
import 'package:onboarding/onboarding.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class onboard extends StatefulWidget {
  const onboard({Key? key}) : super(key: key);

  @override
  _onboardState createState() => _onboardState();
}

const String _heroAddTodo = 'add-todo-hero';
const String _heroAddTodo2 = 'add-todo-hero2';

class _onboardState extends State<onboard> {
  String page1 = "none";
  String page2 = "none";
  List boolarr1 = [false, false, false, false, false];
  List boolarr2 = [false, false, false, false, false];
  final TextEditingController UsernameControl = TextEditingController();
  String path = '';
  File? Cover;
  FilePickerResult? result;
  late PlatformFile file;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final name = FirebaseAuth.instance.currentUser!.displayName;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference banner = FirebaseFirestore.instance.collection('banner');

  @override
  Widget build(BuildContext context) {

    final onboardingPagesList = [
      PageModel(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText('Welcome'),
                        ]),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Edit Avatar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Tap to change',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Container(
                width: 200,
                height: 200,
                child: Stack(
                  children: <Widget>[
                    if (path == '') ...[
                      GestureDetector(
                        onTap: () async {
                          Cover = await CoverArtSelecter();
                          setState(() {
                            path = Cover!.path.toString();
                          });
                        },
                        child: CircleAvatar(
                          radius: 200.0,
                          backgroundImage: NetworkImage(
                              'https://static.wikia.nocookie.net/p__/images/5/5b/Josuke_Higashikata_anime.png/revision/latest/top-crop/width/360/height/360?cb=20200203081848&path-prefix=protagonist'),
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
                          radius: 200.0,
                          backgroundImage: FileImage(
                            File(path),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      )
                    ],
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Pick a Username',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Default: ' + name!,
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: UsernameControl,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Username',
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
                    CupertinoIcons.person_alt_circle_fill,
                    color: Colors.white54,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      PageModel(
        widget: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'Tell us about yourself',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'Add your skills',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Hero(
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
                  dense: true,
                  title: Text(
                    page1,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  trailing: Icon(
                    CupertinoIcons.forward,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    final List result = await Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return _AddTodoPopupCard();
                    }));
                    boolarr1 = result;
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
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'What are you looking for',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Hero(
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
                  dense: true,
                  title: Text(
                    page2,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  trailing: Icon(
                    CupertinoIcons.forward,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    final List result = await Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return _AddTodoPopupCard2();
                    }));
                    boolarr2 = result;
                    if (result.toString() != 'null') {
                      setState(() {
                        page2 = tagProcess(result);
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      PageModel(
        widget: Column(
          children: [
            Image.network(
                'https://images.macrumors.com/t/vMbr05RQ60tz7V_zS5UEO9SbGR0=/1600x900/smart/article-new/2018/05/apple-music-note.jpg'),
            Text(
              'Go absolutely bonkers',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              'Mate do ya thang',
            ),
            Text(
              'Add some other shit',
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Onboarding(
        pagesContentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        skipButtonStyle: SkipButtonStyle(
          skipButtonText: Text(
            'Skip',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          skipButtonColor: Theme.of(context).colorScheme.secondary,
        ),
        background: Colors.black,
        proceedButtonStyle: ProceedButtonStyle(
          proceedpButtonText: Text(
            'Jump in',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          proceedButtonColor: Theme.of(context).colorScheme.secondary,
          proceedButtonRoute: (context) async {
            if (path != '') {
              await Uploader(uid, Cover!);
            }
            await FireWrite(boolarr1, boolarr2);
            Navigator.pushNamed(context, '/ok');
          },
        ),
        pages: onboardingPagesList,
        indicator: Indicator(
          closedIndicator: ClosedIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
          activeIndicator: ActiveIndicator(
            color: Colors.white,
          ),
          indicatorDesign: IndicatorDesign.line(
            lineDesign: LineDesign(
              lineType: DesignType.line_nonuniform,
            ),
          ),
        ),
      ),
    );
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

  Future<File> CoverArtSelecter() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    file = result!.files.first;
    return (File(file.path.toString()));
  }

  FireWrite(List<dynamic> arr1, List<dynamic> arr2) async {
    List<String> tag = [];
    List<String> lookout = [];
    print(arr1[0]);
    print(arr1[1]);
    for (int i = 0; i <= arr1.length - 1; i++) {
      tag.add(arr1[i].toString());
      lookout.add(arr2[i].toString());
    }
    print(tag);
    final fyeuser = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot doc = await users.doc(fyeuser.uid).get();
    if (UsernameControl.text.isEmpty) {
      UsernameControl.text = fyeuser.displayName!;
    }

    if (doc.exists) {
      users.doc(fyeuser.uid).update(
          {"username": UsernameControl.text, "tag": tag, "lookout": lookout});
      banner.doc(fyeuser.uid).update(
          {"username": UsernameControl.text});
    }
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
    users.doc(uid).update({
      "avatarUrl": DPLink.toString(),
    });
  }

  Future<String> getUrl(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(s);
    var url = await ref.getDownloadURL();
    return url;
  }
}

class _AddTodoPopupCard extends StatefulWidget {
  const _AddTodoPopupCard({Key? key}) : super(key: key);

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
  const _AddTodoPopupCard2({Key? key}) : super(key: key);

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
