import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/PopUp/CustomRectTween.dart';
import 'package:lessgoo/PopUp/HeroDialogRoute.dart';

class time123 extends StatefulWidget {
  const time123({Key? key}) : super(key: key);

  @override
  _time123State createState() => _time123State();
}

class _time123State extends State<time123> {
  int? number1;
  final usersRef = FirebaseFirestore.instance.collection('users');
  Map<String, List> fruits = Map();
  final items = ['Singer','Producer','Instrumentalist','Cover Artist','Sound Engineer'];
  String ab = 'none';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    number1=new Random().nextInt(10);
  }

  @override
  Widget build(BuildContext context) {
    fruits["apple"] = ['v', 'i', 'k', 'r', 'a', 'm'];
    fruits['what'] = ['true', 'false', 'false', 'true', 'false'];
    final qSnap = usersRef.where('tag',isEqualTo: 'ab').orderBy('fruits.1').limit(2).snapshots();
    final query = usersRef.where('id',isEqualTo: '5vvblcPKqSg9rb1W6gHCCio2Qnx2').snapshots();
    String temp='';

    Future<void> bruh() async {
      for(int i=0;i<=10;i++){
        int otp = new Random().nextInt(10);
        print(otp);
        await usersRef.doc('d0NL4xpXL2T2V5Qy7ud3Jh9sGlI3').update({"indexer.$i": otp});
      }
      print(fruits["apple"]?.elementAt(1).toString());
    }

    Future<void> reset() async {
      await usersRef.doc('TreXJuCf7VV4EzGuhWCFUkcn52k1').update({"indexer": 4});
    }

    Future<void> printer() async {
      usersRef.doc('a').get().then((value) async {
        var fields = value.data();
        print(fields!["fruits"]);
      });
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(number1.toString(), style: TextStyle(fontSize: 40),),
          CupertinoButton(child: Text('indexer'), onPressed: (){bruh();}),
          CupertinoButton(child: Text('reset'), onPressed: (){reset();}),
          CupertinoButton(child: Text('printer'), onPressed: (){printer();}),
          DropdownButton(
            underline: Container(),
            iconEnabledColor: Colors.black,
              icon: Icon(Icons.ice_skating),
              items: items.map(buildMenuItems).toList(),
              onChanged: (value) => setState(() {
                ab=value.toString();
              })
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent), //Elevated Button Background
            onPressed: (){}, //make onPressed callback empty
            child:DropdownButton(
              style: TextStyle(color: Colors.white), //Dropdown font color
              dropdownColor: Colors.redAccent, //dropdown menu background color
              icon: Icon(Icons.arrow_downward, color:Colors.white), //dropdown indicator icon
              underline: Container(),
                onChanged: (value) => setState(() {
                  ab=value.toString();
                }),
              items: items.map(buildMenuItems).toList(),
            ),
          ),
          Container(
            height: 120,
            child: StreamBuilder<QuerySnapshot>(
              stream: query,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                    print(snapshot.data?.size); // so fucking stupid
                    return ListTile(
                      title: Text(data['tag'].toString()),
                      onTap: (){
                        List abc=data['tag'];
                        arrtotag(abc);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> arrtotag(List<dynamic> abc) async {
    List tag=[];
      if(abc[0]==true){
        tag.add('Singer');
      }
      if(abc[1]==true){
        tag.add('Producer');
      }
      if(abc[2]==true){
        tag.add('Instrumentalist');
      }
      if(abc[3]==true){
        tag.add('Audio engineer');
      }
      if(abc[4]==true){
        tag.add('Cover artist');
      }
      print(tag);
    await usersRef.doc('5vvblcPKqSg9rb1W6gHCCio2Qnx2').update({"stringTag": tag});
  }

  DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
    value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 20),
      )
  );
}