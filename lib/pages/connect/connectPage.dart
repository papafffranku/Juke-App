import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final uid = FirebaseAuth.instance.currentUser!.uid;

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  late List<dynamic> users;
  int count = 0;
  String swipes = '0';
  String time = ' ';
  bool? check;

  @override
  void initState() {
    getUsersData();
    super.initState();
  }

  void getUsersData() {
    DateTime lastTime;
    usersRef.doc(uid).get().then((value) {
      var fields = value.data();
      lastTime = (fields!['swipe'] as Timestamp).toDate();
      swipes = fields['swipeno'];
      setState(() {
        check = connect(lastTime);
        time = lastTime.hour.toString() +
            ':' +
            lastTime.minute.toString() +
            '  ' +
            lastTime.weekday.toString() +
            '/' +
            lastTime.month.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    CollectionReference usersref =
        FirebaseFirestore.instance.collection('users');
    int sleft=10-int.parse(swipes);

    return Scaffold(
      backgroundColor: Colors.black,
      body: ColorfulSafeArea(
        child: ListView(
          children: [
            landingPageHeader(context, 'Connect', Icons.filter_list, false),
            Center(
                child: Text('Swipes left: '+sleft.toString(),style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
            ),
            SizedBox(
              height: 10,
            ),
            if (check == true && sleft>0) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: swipe(screenwidth),
              )
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: outofswipes(time),
              )
            ],
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  bool connect(DateTime lastTime) {
    DateTime timestamp = DateTime.now();
    if (timestamp.isBefore(lastTime)) {
      return false;
    } else {
      return true;
    }
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

  String tagProcess(arr) {
    String tagger = '';
    for (int i = 0; i <= arr.length - 1; i++) {
      if (arr[i].toString() == 'true') {
        if (i == 0) {
          tagger = ' Singer ';
        } else if (i == 1) {
          tagger = tagger + ' Producer ';
        } else if (i == 2) {
          tagger = tagger + ' Instrumentalist ';
        } else if (i == 3) {
          tagger = tagger + ' Audio Engineer ';
        } else if (i == 4) {
          tagger = tagger + ' Cover Artist ';
        }
      }
    }
    return (tagger);
  }

  timeWrite(DateTime test) async {
    DateTime timestamp = DateTime.now();
    DateTime next = timestamp.add(new Duration(hours: 24));

    usersRef.doc(uid).update({
      "swipe": next,
    });
  }

  Widget swipe(double screenwidth) {
    return FutureBuilder<QuerySnapshot>(
        future: usersRef.limit(10).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var abx=snapshot.data!.docs..shuffle();
            final List username =
                snapshot.data!.docs.map((doc) => doc['username']).toList();
            final List bio =
                snapshot.data!.docs.map((doc) => doc['bio']).toList();
            final List picture =
                snapshot.data!.docs.map((doc) => doc['avatarUrl']).toList();
            final List tag =
                snapshot.data!.docs.map((doc) => doc['tag']).toList();
            final List lookout =
                snapshot.data!.docs.map((doc) => doc['lookout']).toList();
            return AnimatedSwitcher(
                switchInCurve: Curves.decelerate,
                switchOutCurve: Curves.easeOutBack,
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation);
                  return ClipRect(
                    child: SlideTransition(
                        position: offsetAnimation, child: child),
                  );
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
                                        image: NetworkImage(picture[count]))),
                              ),
                              Container //Gradient
                                  (
                                height: 475,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 350.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xff1D293E),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            )),
                                        width: screenwidth / 1.45,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 180,
                                                    child: Text(
                                                      tagProcess(tag[count]),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 60,
                                                          width:
                                                              screenwidth / 2.2,
                                                          child: Text(
                                                            username[count],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                                                            color:
                                                                Colors.black))
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
                                            int x=int.parse(swipes);
                                            if (count == username.length - 1) {
                                              count = 0;
                                            } else {
                                              count++;
                                              x++;
                                              swipes=x.toString();
                                            }
                                          });
                                        },
                                        child: Icon(
                                          CupertinoIcons.shuffle,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(20),
                                          primary:
                                              Colors.red, // <-- Button color
                                          onPrimary:
                                              Colors.red, // <-- Splash color
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'About',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 25),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        actionButton('Message'),
                                        SizedBox(width: 8),
                                        actionButton('View Profile')
                                      ],
                                    )
                                  ],
                                ),
                                Text(bio[count].toString(),style: TextStyle(fontSize: 18)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Looking for',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 25),
                                ),
                                CupertinoButton(
                                    child: Text('yo bo'),
                                    onPressed: () {
                                      setState(() {
                                        check = false;
                                      });
                                    }),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(tagProcess(lookout[count]),style: TextStyle(fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }
        });
  }

  Widget outofswipes(String time) {
    return Center(
        child: Column(
      children: [
        Text(
          'Yikes!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "looks like you're all out of shuffles",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "unlocks next at: ",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              time,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          label: Text("Refresh"),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () {},
          icon: Icon(CupertinoIcons.refresh),
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'Grow the community',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'This app is only as great as the people in it. So, go ahead and share this app with your friends.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        ElevatedButton.icon(
          label: Text("Share"),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () {},
          icon: Icon(Icons.share),
        ),
      ],
    ));
  }
}
