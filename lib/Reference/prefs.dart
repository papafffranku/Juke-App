import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/uploadsong/ModalScreens.dart';
import 'package:lessgoo/pages/uploadsong/SuccessUpload.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class prefs extends StatefulWidget {
  const prefs({Key? key}) : super(key: key);

  @override
  _prefsState createState() => _prefsState();
}

class _prefsState extends State<prefs> {
  final modal = ModalScreens();
  int c1 = 0;
  final usersRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setter();
  }

  @override
  Widget build(BuildContext context) {
    final query = usersRef.orderBy('timestamp', descending: true).limit(4).snapshots();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'The new guys',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Go say hi!',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/yo');
                      },
                      child: Text('go to new paagis'),

                    ),
                    // Container(
                    //   height: 400,
                    //   child: StreamBuilder<QuerySnapshot>(
                    //     stream: query,
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<QuerySnapshot> snapshot) {
                    //       if (snapshot.hasError) {
                    //         return Text('Something went wrong');
                    //       }
                    //
                    //       if (snapshot.connectionState == ConnectionState.waiting) {
                    //         return Text("Loading");
                    //       }
                    //
                    //       return GridView(
                    //         shrinkWrap: true,
                    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 2,
                    //               mainAxisSpacing: 10,
                    //               childAspectRatio: 0.7,
                    //               crossAxisSpacing: 5,
                    //           ),
                    //           scrollDirection: Axis.vertical,
                    //         children:
                    //         snapshot.data!.docs.map((DocumentSnapshot document) {
                    //           Map<String, dynamic> data =
                    //           document.data()! as Map<String, dynamic>;
                    //           if (data['id']!='uid'){
                    //             return Container(
                    //               decoration: BoxDecoration(
                    //                   color: Colors.purple,
                    //                   border: Border.all(
                    //                     color: Colors.purple,
                    //                   ),
                    //                   borderRadius: BorderRadius.all(Radius.circular(15))),
                    //               child: Center(
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.symmetric(horizontal: 8),
                    //                     child: Column(
                    //                       children: [
                    //                         SizedBox(
                    //                           height: 10,
                    //                         ),
                    //                         CircleAvatar(
                    //                           radius: 30,
                    //                           backgroundImage:
                    //                           NetworkImage(data['avatarUrl']),
                    //                         ),
                    //                         Text(
                    //                           data['username'],
                    //                           maxLines: 3,
                    //                           overflow: TextOverflow.ellipsis,
                    //                           style: TextStyle(fontSize: 20),
                    //                         ),
                    //                         SizedBox(
                    //                           height: 5,
                    //                         ),
                    //                         Container(
                    //                           child: Text(
                    //                             data['avatarUrl'],
                    //                             maxLines: 3,
                    //                             overflow: TextOverflow.ellipsis,
                    //                             style: TextStyle(color: Colors.white70),
                    //                           ),
                    //                         ),
                    //                         Expanded(
                    //                           child: Align(
                    //                             alignment: Alignment.bottomCenter,
                    //                             child: Padding(
                    //                               padding: const EdgeInsets.only(bottom: 10),
                    //                               child: ElevatedButton(
                    //                                 onPressed: () {},
                    //                                 child: Text('View profile'),
                    //                                 style: ElevatedButton.styleFrom(
                    //                                   shape: RoundedRectangleBorder(
                    //                                     borderRadius: BorderRadius.circular(12), // <-- Radius
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   )),
                    //             );
                    //           }
                    //           else{
                    //             return SizedBox();
                    //           }
                    //         }).toList(),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }

  setter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0);
    setState(() {
      c1 = counter;
    });
  }
}
