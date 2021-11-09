import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class time123 extends StatefulWidget {
  const time123({Key? key}) : super(key: key);

  @override
  _time123State createState() => _time123State();
}

class _time123State extends State<time123> {
  final usersRef = FirebaseFirestore.instance.collection('tim');


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
      future: usersRef.doc('1').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          DateTime test = (data['timestamp'] as Timestamp).toDate();
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text('yo'),
                  Text(data['timestamp'].toString()),
                  CupertinoButton(
                      child: Text('date print'),
                      onPressed: () {
                        createUserInFirestore(test);
                      })
                ],
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }

  createUserInFirestore(DateTime test) async {

    DateTime timestamp = DateTime.now();
    DateTime fiftyDaysFromNow = timestamp.add(new Duration(hours: 24));
    DateTime past = timestamp.subtract(new Duration(days: 2));

    final fyeuser = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot doc = await usersRef.doc('1').get();

    // usersRef.doc('1').set({
    //   "timestamp": timestamp,
    //   "later": fiftyDaysFromNow,
    // });


    //checks if current time is greater than database
    // if(timestamp.isBefore(test)){
    //   print('first');
    //   print(timestamp);
    //   print(test);
    // }
    // if(timestamp.isAfter(test)){
    //   print('second');
    //   print(timestamp);
    //   print(test);
    // }
  }
}
