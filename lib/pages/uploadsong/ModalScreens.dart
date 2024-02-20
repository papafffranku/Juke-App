import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class ModalScreens {
  void loadingmodalscreen(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
        isDismissible: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.1, 0.9],
                    colors: [Colors.deepPurple, Colors.transparent])),
            height: screenheight * .80,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: FlareActor(
                    'lib/assets/MusicLoad.flr',
                    animation: 'searching',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Hang on, we're still uploading....",
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "This takes about 1-2 minutes",
                  style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  child: LinearProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        });
  }

  void newUserRec(BuildContext context, String uid) {
    final usersRef = FirebaseFirestore.instance.collection('users');
    final query =
        usersRef.orderBy('timestamp', descending: true).limit(4).snapshots();
    double screenheight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: (BuildContext bc) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FadeIn(
                  duration: Duration(milliseconds: 750),
                  curve: Curves.decelerate,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: query,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          return GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 5,
                            ),
                            scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              if (data['id'] != uid) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Color(0x1FFFFFFF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              NetworkImage(data['avatarUrl']),
                                        ),
                                        Text(
                                          data['username'],
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Text(
                                            data['bio'],
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            data['stringTag']
                                                .toString()
                                                .replaceAll("[", "")
                                                .replaceAll("]", ""),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  'View profile',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .hintColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                );
                              } else {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Use the ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            TextSpan(
                                              text: 'connect page ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .hintColor),
                                            ),
                                            TextSpan(
                                              text:
                                                  'to filter by your preference ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
