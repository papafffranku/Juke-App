import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  bool expanded = false;
  late List<dynamic> users;
  int count = 0;

  @override
  void initState() {
    getUsers();
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
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ColorfulSafeArea(
        child: ListView(
          children: [
            landingPageHeader(context, 'Connect', Icons.filter_list, false),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FutureBuilder<QuerySnapshot>(
                  future: usersRef.get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final List username = snapshot.data!.docs
                          .map((doc) => doc['username'])
                          .toList();
                      final List bio =
                          snapshot.data!.docs.map((doc) => doc['bio']).toList();
                      final List picture = snapshot.data!.docs
                          .map((doc) => doc['avatarUrl'])
                          .toList();
                      final List email = snapshot.data!.docs
                          .map((doc) => doc['email'])
                          .toList();
                      final List songs = snapshot.data!.docs
                          .map((doc) => doc['email'])
                          .toList();
                      final List tag = snapshot.data!.docs
                          .map((doc) => doc['songs'])
                          .toList();
                      print(username);
                      return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                                opacity: animation,
                                child: child);
                          },
                          child: Container(
                            key: ValueKey<int>(count),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    key: UniqueKey(),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 475,
                                          width: screenwidth,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20)),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      picture[count]))),
                                        ),
                                        Container //Gradient
                                            (
                                          height: 475,
                                          // decoration: BoxDecoration(
                                          //     color: Colors.black,
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(8.0)),
                                          //     gradient: LinearGradient(
                                          //         begin: FractionalOffset.topCenter,
                                          //         end:
                                          //             FractionalOffset.bottomCenter,
                                          //         colors: [
                                          //           Theme.of(context)
                                          //               .accentColor
                                          //               .withOpacity(0.2),
                                          //           Theme.of(context).accentColor,
                                          //         ],
                                          //         stops: [
                                          //           0.5,
                                          //           1.0
                                          //         ])),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 350.0),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff1D293E),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(20),
                                                      )),
                                                  width: screenwidth / 1.5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Artist',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                  fontSize: 14),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    username[
                                                                        count],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w800),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Container(
                                                            //   child: Row(
                                                            //     children: [
                                                            //       Text(
                                                            //         "Looking for: ",
                                                            //         textAlign:
                                                            //             TextAlign
                                                            //                 .center,
                                                            //         style: TextStyle(
                                                            //             color: Colors
                                                            //                     .grey[
                                                            //                 400],
                                                            //             fontSize:
                                                            //                 12),
                                                            //       ),
                                                            //       tagHolder(
                                                            //           'Producers'),
                                                            //       tagHolder(
                                                            //           'Singers')
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 65,
                                                          width: 65,
                                                          child: Stack(
                                                            children: [
                                                              PlayMusic(),
                                                              Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .play_arrow_rounded,
                                                                      color: Colors
                                                                          .black))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (count ==
                                                          username.length - 1) {
                                                        count = 0;
                                                      } else {
                                                        count++;
                                                        print(count);
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    CupertinoIcons.shuffle,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: CircleBorder(),
                                                    padding: EdgeInsets.all(20),
                                                    primary: Colors
                                                        .red, // <-- Button color
                                                    onPrimary: Colors
                                                        .red, // <-- Splash color
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        color: Color(0xff1D293E)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'about',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 25),
                                          ),
                                          Text(bio[count].toString()),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              actionButton('Message'),
                                              SizedBox(width: 10),
                                              actionButton('View Profile')
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     ElevatedButton(
                                  //       onPressed: () {},
                                  //       child: Icon(
                                  //           CupertinoIcons.chat_bubble_2_fill,
                                  //           color: Colors.white),
                                  //       style: ElevatedButton.styleFrom(
                                  //         shape: CircleBorder(),
                                  //         padding: EdgeInsets.all(20),
                                  //         primary:
                                  //             Colors.green, // <-- Button color
                                  //         onPrimary:
                                  //             Colors.green, // <-- Splash color
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     ElevatedButton(
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           if (count == username.length - 1) {
                                  //             count = 0;
                                  //           } else {
                                  //             count++;
                                  //             print(count);
                                  //           }
                                  //         });
                                  //       },
                                  //       child: Icon(CupertinoIcons.shuffle,
                                  //           color: Colors.white),
                                  //       style: ElevatedButton.styleFrom(
                                  //         shape: CircleBorder(),
                                  //         padding: EdgeInsets.all(20),
                                  //         primary:
                                  //             Colors.red, // <-- Button color
                                  //         onPrimary:
                                  //             Colors.red, // <-- Splash color
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ));
                    }
                  }),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(String actionString) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: actionString != 'Message'
              ? Theme.of(context).backgroundColor
              : Color(0xffd0b517),
          onPrimary: Colors.white,
        ),
        onPressed: () {},
        child: Text(actionString));
  }

  Widget tagHolder(String tag) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff1B190E),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          tag,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget PlayMusic() {
    return FlareActor(
      'lib/assets/Loading.flr',
      animation: 'Alarm',
      fit: BoxFit.contain,
    );
  }
}
