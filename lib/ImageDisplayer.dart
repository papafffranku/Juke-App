import 'package:flutter/material.dart';
import 'package:lessgoo/urlgetter.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  String? url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    abc();
  }

  void abc() async {
    setState(() async {
      url = await ImageDisplay().getUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(url!)),
      ),
    );
  }
}
