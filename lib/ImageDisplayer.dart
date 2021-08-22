import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  FilePickerResult? result;
  late PlatformFile file;

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    CollectionReference users = FirebaseFirestore.instance.collection('tracks').doc('p4hIaEB2rpYmzMm2H1G0zQc5AbG3').collection("publicSong");

    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder:
            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          else {
            var list = snapshot.data!.docs;

            return Scaffold(
              body: Column(
                children: [
                  Text("Public Songs"),
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index]["SongName"]),
                          subtitle: Text(list[index]["SongDesc"]),
                          leading: Image.network(list[index]["coverLink"]),
                        );
                      },
                      itemCount: list.length,
                  ),
                ],
              ),
            );
          }
        });
  }
}