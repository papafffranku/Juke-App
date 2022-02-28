import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/uploadsong/ModalScreens.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final modal = ModalScreens();
  double boxheight=50;

  void _expandbox(){
    setState(() {
      boxheight=300;
    });
  }
  void _collapsebox(){
    setState(() {
      boxheight=50;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget not(){
      return Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'See new users',
                  style: TextStyle(fontSize: 20,color: Theme.of(context).accentColor),
                ),
                WidgetSpan(
                  child: Icon(CupertinoIcons.forward,color: Theme.of(context).accentColor,size: 19,),
                ),
              ],
            ),
          ),
          Text(
            'Make them feel welcome',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(
            height: 5,
          )
        ],
      );
    }
    Widget yes(){
      return Column(
        children: [
          Text(
            'crazy',
            style: TextStyle(color: Colors.white70),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'See new users',
                  style: TextStyle(fontSize: 20,color: Theme.of(context).accentColor),
                ),
                WidgetSpan(
                  child: Icon(CupertinoIcons.forward,color: Theme.of(context).accentColor,size: 19,),
                ),
              ],
            ),
          ),
          Text(
            'Make them feel welcome',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'See new users',
                  style: TextStyle(fontSize: 20,color: Theme.of(context).accentColor),
                ),
                WidgetSpan(
                  child: Icon(CupertinoIcons.forward,color: Theme.of(context).accentColor,size: 19,),
                ),
              ],
            ),
          ),
          Text(
            'Make them feel welcome',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(
            height: 5,
          )
        ],
      );
    }

    var defaulty=not;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          CupertinoButton(child: Text('expand'), onPressed: (){
            _expandbox();
          }),
          CupertinoButton(child: Text('collapse'), onPressed: (){
            _collapsebox();
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: boxheight,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff161616),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
