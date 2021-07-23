import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lessgoo/FirebaseApi.dart';
import 'package:lessgoo/ImageDisplayer.dart';
import 'dart:io';
import 'package:path/path.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  FilePickerResult? result;
  File? file;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    final path = result!.files.single.path;

    setState(() => file = File(path!));
  }

  Future uploadFile() async {
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    FirebaseApi.uploadFile(destination, file!);
  }

  @override
  Widget build(BuildContext context) {
    File UPF;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: selectFile, child: Text('Upload')),
          TextButton(onPressed: uploadFile, child: Text('Publish')),
        ],
      )),
    );
  }
}
