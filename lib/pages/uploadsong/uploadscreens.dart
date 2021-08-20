import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lessgoo/pages/uploadsong/ModalScreens.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lessgoo/pages/uploadsong/SuccessUpload.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SongUpload extends StatefulWidget {
  final File UPFcon;
  final String uid;

  const SongUpload({Key? key, required this.UPFcon, required this.uid}) : super(key: key);

  @override
  _SongUploadState createState() => _SongUploadState();
}

class _SongUploadState extends State<SongUpload> {
  final modal = ModalScreens();
  final tracksRef = FirebaseFirestore.instance.collection('tracks');
  final coversRef = FirebaseFirestore.instance.collection('cover');
  late AudioPlayer advancedPlayer;
  FilePickerResult? result;
  late PlatformFile file;
  File? Cover;
  String path='';
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
    Song_key = widget.uid + audiofileName;
    Cover_key = "cover" + Song_key;

    return CupertinoPageScaffold(
      backgroundColor: Color(0xff0e0e15),
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
                    final DocumentSnapshot doc = await tracksRef.doc(widget.uid).collection('publicSong').doc(Song_key).get();
                    final DocumentSnapshot doc1 = await tracksRef.doc(widget.uid).collection('privateSong').doc(Song_key).get();
                    int check = await FieldChecker();
                    if(check==2 && !doc.exists && !doc1.exists){
                      modal.loadingmodalscreen(context);
                      await Uploader(Cover!,Cover_key,UPF1,Song_key,widget.uid);
                      Navigator.pop(context);
                      pushNewScreen(context, screen: SuccessUpload(),withNavBar: true);
                    }else if(doc.exists || doc1.exists){
                      Snackbar("Looks like you've already uploaded this audio file before");
                    }
                  },
                  child: Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    color: CupertinoColors.activeBlue,
                    size: 30,
                  )),
              leading: CupertinoNavigationBarBackButton(
                color: CupertinoColors.activeBlue,
                onPressed: (){
                  Navigator.pop(context);
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
    else if (path=='') {
      Snackbar('You must choose some cover art');
      return 1;
    }
    else if (SongDescController.text.length >= 140) {
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

  Future<void> Uploader(File cover, String cover_key, File upf1, String song_key, String uid) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('track/$song_key')
          .putFile(upf1);
      await firebase_storage.FirebaseStorage.instance
          .ref('cover/$cover_key')
          .putFile(cover);
    } catch (e) {
      print(e);
    }
    String songLink=await getUrl('track/$song_key');
    String coverLink=await getUrl('cover/$cover_key');
    await dbsong(song_key, upf1, cover_key, SongNameController.text, SongDescController.text, uid, songLink, coverLink);
  }

  Future<void> dbsong(String song_key, File upf1, String cover_key, String sname, String desc, String uid, String songLink, String coverLink) async {
    final DateTime timestamp = DateTime.now();

    if (prv==true){
      await tracksRef.doc(widget.uid).collection('privateSong').doc(Song_key).set({
        "id": song_key,
        "SongName": sname,
        "SongDesc": desc,
        "Artist": uid,
        "songLink": songLink,
        "coverLink": coverLink,
        "privacy": 'private',
        "timestamp": timestamp
      });
    }else{
      await tracksRef.doc(widget.uid).collection('publicSong').doc(Song_key).set({
        "id": song_key,
        "SongName": sname,
        "SongDesc": desc,
        "Artist": uid,
        "songLink": songLink,
        "coverLink": coverLink,
        "privacy": 'public',
        "timestamp": timestamp
      });
    }
  }

  Future<String> getUrl(String s) async {
    final ref = FirebaseStorage.instance.ref().child(s);
    var url = await ref.getDownloadURL();
    return url;
  }

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
}
