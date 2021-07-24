import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class FireStore_Trial extends StatefulWidget {
  const FireStore_Trial({Key? key}) : super(key: key);

  @override
  _FireStore_TrialState createState() => _FireStore_TrialState();
}


class _FireStore_TrialState extends State<FireStore_Trial> {
  late List<dynamic> users;

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
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(future: usersRef.get(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Text('loading');
        }
        final List<Text> children = snapshot.data!.docs.map((doc) => Text(doc['username'])).toList();
        return Container(
          child: ListView(
            children: children,

          ),
        );
      },)
    );
  }
}
