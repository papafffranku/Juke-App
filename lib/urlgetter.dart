import 'package:firebase_storage/firebase_storage.dart';

class ImageDisplay {
  Future<String> getUrl() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('files/Vagabond - Vol.4 Chapter 40 _ Agon - 16.jpg');
    var url = await ref.getDownloadURL();
    return url;
  }
}
