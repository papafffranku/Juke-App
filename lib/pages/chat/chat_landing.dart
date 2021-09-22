import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/chat/chat_search.dart';
import 'package:lessgoo/pages/widgets/routepageheader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ChatLanding extends StatefulWidget {
  const ChatLanding({Key? key}) : super(key: key);

  @override
  _ChatLandingState createState() => _ChatLandingState();
}

class _ChatLandingState extends State<ChatLanding> {
  _onSearchTap() {
    pushNewScreen(context, screen: ChatSearch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: routePageAppBar(
          context: context,
          icon: CupertinoIcons.search,
          function: _onSearchTap),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: routeHeader(title: 'Chats'),
          )
        ],
      )),
    );
  }
}
