import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class time123 extends StatefulWidget {
  const time123({Key? key}) : super(key: key);

  @override
  _time123State createState() => _time123State();
}
String a='n';


class _time123State extends State<time123> {
  final usersRef = FirebaseFirestore.instance.collection('users');
  int count=0;
  Map<String, List> fruits= Map();

  @override
  Widget build(BuildContext context) {
    fruits["apple"]=['v','i','k','r','a','m'];
    fruits['what']=['true','false','false','true','false'];
    final qSnap=usersRef.where('b.apple', arrayContainsAny: ['v']).limit(2).snapshots();

    Future<void> bruh() async {
      await usersRef
          .doc('wut')
          .update({
        "b": fruits
      });
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          CupertinoButton(child: Text('refresh'), onPressed: (){setState(() {
            a='v';
            print(a);
          });}),
          CupertinoButton(child: Text('modal'), onPressed: (){
            connectmodalscreen(context);
          }),
          CupertinoButton(child: Text('b'), onPressed: () async {
            await bruh();
          }),
          Container(
            height: 120,
            child: StreamBuilder<QuerySnapshot>(
              stream: qSnap,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    print(snapshot.data?.size); // so fucking stupid
                    return ListTile(
                      title: Text(data['a']),
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

  void connectmodalscreen(BuildContext context) {

    Color enabled = Theme.of(context).accentColor;
    Color disabled = Colors.white;

    double screenheight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
        isDismissible: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.1, 0.9],
                    colors: [Theme.of(context).secondaryHeaderColor, Colors.transparent])),
            height: screenheight * .80,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                TextButton(
                    child: Text(
                      "Singer".toUpperCase(),
                      style: TextStyle(fontSize: 14,color: Colors.black),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )
                        )
                    ),
                    onPressed: () => null
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    child: Text(
                      "producer".toUpperCase(),
                      style: TextStyle(fontSize: 14,color: Colors.black),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all<Color>(enabled),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )
                        )
                    ),
                    onPressed:(){

                    }
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    child: Text(
                      "Cover Artist".toUpperCase(),
                      style: TextStyle(fontSize: 14,color: Colors.black),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )
                        )
                    ),
                    onPressed: () => null
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    child: Text(
                      "Instrumentalist".toUpperCase(),
                      style: TextStyle(fontSize: 14,color: Colors.black),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )
                        )
                    ),
                    onPressed: () => null
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }
}
