import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TextOverImage extends StatefulWidget {
  @override
  _TextOverImageState createState() => _TextOverImageState();
}

class _TextOverImageState extends State<TextOverImage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final usersRef = FirebaseFirestore.instance.collection('trails');

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController Text1 = TextEditingController();
  final TextEditingController Text2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int num;

    return FutureBuilder<DocumentSnapshot>(
      future: usersRef.doc('what').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List trailarr = ['1', '2', '3'];
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String number = data['number'].toString();
          num = int.parse(number);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Text(num.toString()),
                  CupertinoButton(
                      child: Text('bruh'),
                      onPressed: () {
                        if (num <= 3) {
                          setState(() {
                            num++;
                            print(num);
                          });
                          usersRef.doc('what').update({"number": num});
                        } else {
                          usersRef.doc('what').update({"number": 1});
                        }
                      })
                ],
              ),
            ),
          );
        }
        return Text("loading");
      },
    );
  }
}
