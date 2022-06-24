import 'dart:math';

import 'package:animation_list/animation_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import 'Konnect.dart';
final items = ['Singer','Producer','Instrumentalist','Cover Artist','Sound Engineer'];

class ope extends StatefulWidget {
  const ope({Key? key}) : super(key: key);

  @override
  State<ope> createState() => _opeState();
}

class _opeState extends State<ope> {
  String abc='Vikram token';
  String tagKeyword='';
  int? mapNumber;

  @override
  void initState() {
    // TODO: implement initState
    mapNumber=new Random().nextInt(10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width=size.width;
    Stream<QuerySnapshot<Map<String, dynamic>>> query = usersRef.where("username", isEqualTo: abc).snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> tagSnap = usersRef.where('stringTag',arrayContainsAny: ['singer']).orderBy('indexer.$mapNumber').limit(10).snapshots();

    DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
        value: item,
        child: FadeIn(
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
          child: Text(
            item,
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        )
    );

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Stack(
            children: [
              Container(
                height: 0.50*width,
                width:width,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: GlassContainer(
                    height: 0.30*width,
                    width: 0.45*width,
                    blur: 60,
                  ),
                ),
              ),

            ],
          ),
          Text(tagKeyword),
          DropdownButton(
            borderRadius: BorderRadius.circular(20),
            hint: Text(''),
            style: TextStyle(color: Colors.white), //Dropdown font color
            dropdownColor: Theme.of(context).accentColor, //dropdown menu background color
            icon: Icon(Icons.filter_list_sharp, color:Colors.white,size: 30,), //dropdown indicator icon
            underline: Container(),
            onChanged: (value) => setState(() {
              if(value=='Singer'){
                tagKeyword='singer';
              }if(value=='Producer'){
                tagKeyword='producer';
              }if(value=='Instrumentalist'){
                tagKeyword='instrumentalist';
              }if(value=='Sound Engineer'){
                tagKeyword='audioeng';
              }if(value=='Cover Artist'){
                tagKeyword='cover';
              }
              setState(() {

              });
              abc=value.toString();
            }),
            items: items.map(buildMenuItems).toList(),
          ),
          ElevatedButton(onPressed: (){
            setState(() {
              abc='Jovin Mathew';
            });
          }, child: Text('yo bo')),
          StreamBuilder<QuerySnapshot>(
            stream: tagSnap,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return AnimationList(
                physics: NeverScrollableScrollPhysics(),
                duration: 1000,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
                  print(snapshot.data?.size); // so fucking stupid
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(data['email']),
                      tileColor: Colors.blue,
                      subtitle: Text(data['username']),
                    )
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
