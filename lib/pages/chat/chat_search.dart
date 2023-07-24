import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/main.dart';
import 'package:lessgoo/methods/database.dart';
import 'package:lessgoo/pages/chat/chatter.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ChatSearch extends StatefulWidget {
  const ChatSearch({Key? key}) : super(key: key);

  @override
  _ChatSearchState createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  String currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
  TextEditingController textEditingController = TextEditingController();
  final database = FirebaseFirestore.instance;
  String? searchString;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  createChatRoomandStart(String otherUser) {
    String chatRoomId = getChatRoomId(otherUser, currentUser);
    List<String> users = [otherUser, currentUser];
    Map<String, dynamic> chatRoomMap = {
      "userId": users,
      "chatroomId": chatRoomId
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: Chatter(chatroomId: chatRoomId, other_user: otherUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          searchString = val.toLowerCase();
                        });
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () => textEditingController.clear(),
                          ),
                          hintText: 'Search'),
                    ),
                  ),
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: (searchString == null || searchString!.trim() == '')
                      ? userRef.snapshots()
                      : userRef
                          .where('searchIndex', arrayContains: searchString)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Text('Error ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return Center(child: CircularProgressIndicator());
                        }

                      case ConnectionState.none:
                        {
                          return Text('No data found');
                        }

                      case ConnectionState.done:
                        {
                          return Text('We are done');
                        }

                      default:
                        return new ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return ListTile(
                              trailing: TextButton(
                                  onPressed: () {
                                    createChatRoomandStart(document.id);
                                  },
                                  child: Text('Message')),
                              title: Text(document['username']),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(document['avatarUrl']),
                              ),
                            );
                          }).toList(),
                        );
                    }
                  },
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
