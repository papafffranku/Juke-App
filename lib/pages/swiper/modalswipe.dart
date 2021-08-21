import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {

  bool shuffle = true;
  late List<dynamic> users;

  List<String> names = ['naruto', 'sasuke', 'kakashi','minato'];
  int _count = 0;

  @override
  void initState() {
    getUsers();
    // TODO: implement initState
    super.initState();
  }

  getUsers() async {
    final QuerySnapshot snapshot = await usersRef.get();

    setState(() {
      users = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Container(
        child: FutureBuilder<QuerySnapshot>(future: usersRef.get(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Text('loading');
            }
            final List username = snapshot.data!.docs.map((doc) => doc['username']).toList();
            final List picture= snapshot.data!.docs.map((doc) => doc['avatarUrl']).toList();
            final List email= snapshot.data!.docs.map((doc) => doc['email']).toList();
            final List songs= snapshot.data!.docs.map((doc) => doc['email']).toList();
            final List tag= snapshot.data!.docs.map((doc) => doc['songs']).toList();
            return Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: Container(
                      key: UniqueKey(),
                      width: screenWidth*0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage:
                              NetworkImage(picture[_count]),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              username[_count],
                              style: TextStyle(
                                  letterSpacing: 1.3,
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('tag[_count]',style: TextStyle(color: Colors.white54,fontSize: 16),),
                            Text("15 Collabs",style: TextStyle(color: Colors.white54,fontSize: 16),),
                            Text(songs[_count],style: TextStyle(color: Colors.white54,fontSize: 16),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Looking for:",style: TextStyle(color: Colors.white54,fontSize: 16),),
                                Text("Singers",style: TextStyle(color: Colors.white,fontSize: 16),),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                                height: 90,
                                width: 90,
                                child: Stack(
                                  children: [
                                    FlareActor(
                                      'lib/assets/Loading.flr',
                                      animation: 'Alarm',
                                      fit: BoxFit.contain,
                                    ),
                                    Center(child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.play_circle_fill,color: Colors.blue,size: 25,))),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      color: Colors.blue,
                      icon: Icon(CupertinoIcons.shuffle_thick),
                      onPressed: () {
                        setState(() {
                          if(_count==names.length-1){
                            _count=0;
                          }
                          else{
                            _count += 1;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },)
    );
  }
}