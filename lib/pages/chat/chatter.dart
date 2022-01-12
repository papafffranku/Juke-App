import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lessgoo/methods/database.dart';

class Chatter extends StatefulWidget {
  final String chatroomId;
  final String other_user;
  const Chatter({Key? key, required this.chatroomId, required this.other_user})
      : super(key: key);

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
                    time: snapshot.data.docs[index].data()["timestamp"],
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
        "sentTo": widget.other_user,
        "timestamp": DateTime.now()
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
      appBar: AppBar(
        title: Text(widget.other_user),
      ),
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
                  decoration: BoxDecoration(
                      color: Color(0xff1f1e1e),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
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
  final Timestamp time;
  final String message;
  final bool isSentbyUser;
  const MessageTile(
      {Key? key,
      required this.message,
      required this.isSentbyUser,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = time.toDate();
    String dateString = DateFormat('hh:mm a').format(dateTime);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSentbyUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  colors: isSentbyUser
                      ? [
                          const Color(0xffd0b517),
                          const Color(0xffcab016),
                        ]
                      : [
                          const Color(0xff1f1e1e),
                          const Color(0xff1f1e1e),
                        ]),
            ),
            child: Row(
              children: [
                Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 1.5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        message,
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    dateString,
                    style: TextStyle(color: Colors.white54, fontSize: 9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
