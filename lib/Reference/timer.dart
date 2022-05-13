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
    final query = usersRef.snapshots();
    String temp='';

    Future<void> indexer1() async {
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
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

                  return GridView(
                    shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                      ),
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      print(snapshot.data?.size); // so fucking stupid
                      if(data['username']=='Jovin'){
                        return ListTile(
                          title: Text(data['username'].toString()),
                          tileColor: Colors.blue,
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              data['avatarUrl'],
                            ),
                          ),
                          onTap: (){
                            List abc=data['tag'];
                            arrtotag(abc);
                          },
                        );
                      }
                      else{
                        return ListTile(
                          title: Text(data['username'].toString()),
                          onTap: (){
                            List abc=data['tag'];
                            arrtotag(abc);
                          },
                        );
                      }
                    }).toList(),
                  );
                },
              ),
            ),
            Container(height: 3000,width: 100,color: Colors.black,),
            Stack(
              children: [
                Container(
                  width: width*0.45,
                  height: width*0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://i.pinimg.com/736x/b8/69/5f/b8695f007aea9a08a0419479217ca6aa.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://m.media-amazon.com/images/M/MV5BYjkxYzE3ODktZjExMi00YmM0LTgwNTMtMmU2OTE3ZDI0NDQzXkEyXkFqcGdeQXVyODEyMDIxNDY@._V1_.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: RadialGradient(
                      center: Alignment(-0.8, 0.8),
                      colors: [Colors.blue, Colors.transparent],
                      radius: 2.4,
                      stops: [0.005, 0.995],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: width * 0.25,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://m.media-amazon.com/images/M/MV5BYjkxYzE3ODktZjExMi00YmM0LTgwNTMtMmU2OTE3ZDI0NDQzXkEyXkFqcGdeQXVyODEyMDIxNDY@._V1_.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: width*0.6,
                              child: Text(
                                'trackname',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white70, fontSize: 16),
                              )),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'artist',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    CupertinoIcons.forward,
                                    color: Theme.of(context).accentColor,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            Text(
                              'Pop',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CircleAvatar(
                              radius: width * 0.125,
                              backgroundImage: NetworkImage(
                                'https://m.media-amazon.com/images/M/MV5BYjkxYzE3ODktZjExMi00YmM0LTgwNTMtMmU2OTE3ZDI0NDQzXkEyXkFqcGdeQXVyODEyMDIxNDY@._V1_.jpg',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
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