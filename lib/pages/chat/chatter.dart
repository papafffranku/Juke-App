import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/methods/database.dart';

class Chatter extends StatefulWidget {
  final String chatroomId;
  const Chatter({Key? key, required this.chatroomId}) : super(key: key);

  @override
  _ChatterState createState() => _ChatterState();
}

class _ChatterState extends State<Chatter> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream? chatMessageStream;

  Widget messageList() {
    return StreamBuilder<dynamic>(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index].data()["message"],
                    isSentbyUser: snapshot.data.docs[index].data()["sentBy"] ==
                        FirebaseAuth.instance.currentUser!.uid,
                  );
                })
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sentBy": userId,
        "timestamp": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversation(widget.chatroomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseMethods.getConversation(widget.chatroomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              messageList(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.pink,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                                hintText: "Message", border: InputBorder.none),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentbyUser;
  const MessageTile(
      {Key? key, required this.message, required this.isSentbyUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSentbyUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isSentbyUser
                  ? [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC),
                    ]
                  : [
                      const Color(0x1AFFFFFF),
                      const Color(0x1AFFFFFF),
                    ]),
        ),
        child: Text(message),
      ),
    );
  }
}
