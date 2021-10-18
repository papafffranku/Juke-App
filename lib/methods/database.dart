import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/pages/connect/connectPage.dart';

class DatabaseMethods {
  getUserbyUserId(String userId) {
    return FirebaseFirestore.instance.collection('users').doc(userId).get();
  }

  createChatRoom(String chatroomId, chatroomMap) {
    chatroomRef.doc(chatroomId).set(chatroomMap).catchError((e) {
      print(e.toString());
    });
  }


  addUserTile(String userId, usertileMap) {}

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

  getChatRooms(String userId) async {
    return chatroomRef.where("userId", arrayContains: userId).snapshots();
  }
}
