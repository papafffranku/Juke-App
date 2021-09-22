import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lessgoo/main.dart';

class DatabaseMethods {
  getUserbyUsername(String userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId)
        .get();
  }

  createChatRoom(String chatroomId, chatroomMap) {
    chatroomRef.doc(chatroomId).set(chatroomMap).catchError((e) {
      print(e.toString());
    });
  }

  addConversation(String chatroomId, messageMap) {
    chatroomRef
        .doc(chatroomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversation(String chatroomId) async {
    return chatroomRef
        .doc(chatroomId)
        .collection("chats")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
