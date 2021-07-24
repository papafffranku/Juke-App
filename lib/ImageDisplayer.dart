import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/urlgetter.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  String? url='https://i.stack.imgur.com/y9DpT.jpg';
  final img = ImageDisplay();


  @override
  void initState() {
    abc();
    super.initState();
  }
  void abc() async {
    url = await ImageDisplay().getUrl();
    setState(() {
      url = url;
    });
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(child: Text('click'),onTap: (){abc();},),
      ),
      body: Image.network(url!)
    );
  }
}
