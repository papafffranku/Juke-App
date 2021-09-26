import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/methods/database.dart';
import 'package:lessgoo/pages/chat/chat_search.dart';
import 'package:lessgoo/pages/chat/chatter.dart';
import 'package:lessgoo/pages/widgets/routepageheader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ChatLanding extends StatefulWidget {
  const ChatLanding({Key? key}) : super(key: key);

  @override
  _ChatLandingState createState() => _ChatLandingState();
}

class _ChatLandingState extends State<ChatLanding> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream? chatRoomsStream;

  roomIdtoUsername(String otherUserId) {}

  Widget chatRoomList() {
    return StreamBuilder<dynamic>(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: (snapshot.data.docs[index]
                        .data()['chatroomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(
                            FirebaseAuth.instance.currentUser!.uid, "")),
                    chatRoomId: snapshot.data.docs[index].data()["chatroomId"],
                  );
                })
            : CircularProgressIndicator();
      },
    );
  }

  _onSearchTap() {
    pushNewScreen(context, screen: ChatSearch());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseMethods
        .getChatRooms(FirebaseAuth.instance.currentUser!.uid)
        .then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: routePageAppBar(
          context: context, icon: CupertinoIcons.add, function: _onSearchTap),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: routeHeader(title: 'Chats'),
          ),
          Container(
            child: chatRoomList(),
          ),
        ],
      )),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({required this.userName, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            screen: Chatter(chatroomId: chatRoomId), withNavBar: false);
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
