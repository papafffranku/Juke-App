import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ColorfulSafeArea(
          child: Column(
        children: [
          landingPageHeader(context, 'Community', false),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'In Progress',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
