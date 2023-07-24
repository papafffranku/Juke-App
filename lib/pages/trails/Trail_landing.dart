import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Trail_landing extends StatefulWidget {
  final File UPFcon;
  final String uid;
  final String number;
  final Color background;
  final Color nextColor;

  const Trail_landing(
      {Key? key,
      required this.UPFcon,
      required this.uid,
      required this.background,
      required this.nextColor,
      required this.number})
      : super(key: key);

  @override
  _Trail_landingState createState() => _Trail_landingState();
}

class _Trail_landingState extends State<Trail_landing> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final usersRef = FirebaseFirestore.instance.collection('trails');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    File image = widget.UPFcon;
    String UID = widget.uid;

    return FutureBuilder<DocumentSnapshot>(
      future: usersRef.doc(widget.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ColorfulSafeArea(
            color: widget.background,
            child: Scaffold(
              body: Container(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [widget.background, widget.nextColor],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Container(
                        child: Image.file(
                          File(image.path),
                          height: height,
                          width: width,
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height - 180),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Material(
                              color:
                                  Theme.of(context).hintColor, // Button color
                              child: InkWell(
                                splashColor: Colors.black, // Splash color
                                onTap: () async {
                                  print(data['number']);
                                },
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      CupertinoIcons.clear,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.black, // Button color
                              child: InkWell(
                                splashColor: Colors.black, // Splash color
                                onTap: () async {
                                  await Uploader(widget.UPFcon);
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.send_sharp,
                                      color: Theme.of(context).hintColor,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Text("loading");
      },
    );
  }

  Future<void> Uploader(File Cover) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('trails/${widget.uid}')
          .putFile(Cover);
    } catch (e) {
      print(e);
    }
    String DPLink = await getUrl('trails/${widget.uid}');
    usersRef.doc(widget.uid).update({
      widget.number: DPLink.toString(),
    });
  }

  Future<String> getUrl(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(s);
    var url = await ref.getDownloadURL();
    return url;
  }
}
