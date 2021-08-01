import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lessgoo/pages/uploadsong/ModalScreens.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SongUpload extends StatefulWidget {
  final File UPFcon;

  const SongUpload({Key? key, required this.UPFcon}) : super(key: key);

  @override
  _SongUploadState createState() => _SongUploadState();
}

class _SongUploadState extends State<SongUpload> {
  final modal = ModalScreens();
  String UID = '';
  bool doneLoad = false;
  late AudioPlayer advancedPlayer;
  FilePickerResult? result;
  late PlatformFile file;
  File? Cover;
  String path = '';
  String Cover_key = '';
  String Song_key = '';
  bool prv = false;
  String prvmsg = 'This song is public';

  //UI Variables
  double blur = 0;

  String genre = '';
  List<String> _gen = ['Hip-Hop', 'Pop', 'Rock'];
  var _current = 'Pop';

  final TextEditingController SongNameController = TextEditingController();
  final TextEditingController SongDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    File UPF1 = widget.UPFcon;
    String audiofileName = UPF1.path.split('/').last;
    Song_key = "song" + UID + audiofileName.substring(0, 5);
    Cover_key = "cover" + UID + audiofileName.substring(0, 5);

    return CupertinoPageScaffold(
      backgroundColor: Color(0xff0e0e15),
      // navigationBar: IOSNAV.NavBarIOS(context, 'Upload Details', 'Home'),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: Color(0xff0e0e15),
              largeTitle: Text(
                'Upload',
                style: TextStyle(color: CupertinoColors.white),
              ),
              trailing: GestureDetector(
                  onTap: () async {
                    await Uploader(Cover!, Cover_key, UPF1, Song_key, UID);
                  },
                  child: Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    color: CupertinoColors.activeBlue,
                    size: 30,
                  )),
              leading: CupertinoNavigationBarBackButton(
                color: CupertinoColors.activeBlue,
                onPressed: () async {
                  int check = await FieldChecker();
                  // if(check==2){
                  //   await Uploader(Cover,Cover_key,UPF1,Song_key,UID);
                  // }
                },
                previousPageTitle: 'Home',
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff424242),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30.0) //
                      ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (path == '') ...[
                      IconButton(
                        onPressed: () async {
                          Cover = await CoverArtSelecter();
                          setState(() {
                            path = Cover!.path.toString();
                          });
                        },
                        icon: Icon(Icons.upload),
                        color: Color(0xff5338FF),
                        iconSize: 50,
                      )
                    ] else ...[
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Cover = await CoverArtSelecter();
                            setState(() {
                              path = Cover!.path.toString();
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.file(
                              File(path),
                              height: 150,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Name",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: TextFormField(
                        controller: SongNameController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            hintText: "Choose a name for your song",
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
                height: 15,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Description",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: SongDescController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            hintText: "Optional",
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Genre ",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.info,
                            color: CupertinoColors.systemGrey,
                          ),
                          tooltip:
                              'This determines which charts your song gets featured on',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        items: _gen.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            this._current = newValueSelected!;
                            print(_current);
                          });
                        },
                        value: _current,
                        style: TextStyle(
                            color: CupertinoColors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Privacy",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    CupertinoSwitch(
                        value: prv,
                        onChanged: (bool value) {
                          setState(() {
                            prv = value;
                            if (prv == false) {
                              prvmsg = 'This song is public';
                            } else if (prv == true) {
                              prvmsg =
                                  'Only you will be able to view this song';
                            }
                            print('prv: $prv');
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    AnimatedCrossFade(
                        firstChild: Text(
                          'This song is public',
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        ),
                        secondChild: Text(
                          'Only you will be able to view this song',
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        ),
                        crossFadeState: prv
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 200)),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "Selected Audio File",
                        style: TextStyle(
                            color: CupertinoColors.white, fontSize: 18),
                      ),
                      Icon(
                        CupertinoIcons.chevron_down,
                        color: CupertinoColors.systemGrey,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        audiofileName,
                        style: TextStyle(
                            color: CupertinoColors.systemGrey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> FieldChecker() async {
    if (SongNameController.text.isEmpty) {
      Snackbar('Song name cannot be empty');
      return 1;
    }
    if (path.isEmpty) {
      Snackbar('You must choose some cover art');
      return 1;
    }
    if (SongDescController.text.length >= 140) {
      Snackbar('Limit Description to 140 words');
      return 1;
    } else {
      return 2;
    }
  }

  Future<File> CoverArtSelecter() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    file = result!.files.first;
    return (File(file.path.toString()));
  }

  Future<void> Uploader(File cover, String cover_key, File upf1,
      String song_key, String uid) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('test/tester1')
          .putFile(upf1);
    } catch (e) {
      print(e);
    }
    await dbsong(song_key, upf1, cover_key, SongNameController.text,
        SongDescController.text, uid);
  }

  Future<void> dbsong(String song_key, File upf1, String cover_key,
      String sname, String desc, String uid) async {}

  void Snackbar(String abc) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        abc,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Color(0xff24B8D6),
    ));
  }

  Widget infoFade() {
    return Container(
      width: 200.0,
      height: 200.0,
      color: Colors.green,
    );
  }
}
