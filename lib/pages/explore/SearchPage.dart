import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/profile/OtherProfile.dart';
import 'package:lessgoo/pages/profile/ProfilePage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  final database = FirebaseFirestore.instance;
  String? searchString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          searchString = val.toLowerCase();
                        });
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () => textEditingController.clear(),
                          ),
                          hintText: 'Search'),
                    ),
                  ),
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: (searchString == null || searchString!.trim() == '')
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('users')
                          .where('searchIndex', arrayContains: searchString)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Text('Error ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return CircularProgressIndicator();
                        }

                      case ConnectionState.none:
                        {
                          return Text('No data found');
                        }

                      case ConnectionState.done:
                        {
                          return Text('We are done');
                        }

                      default:
                        return new ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return InkWell(
                              onTap: () => pushNewScreen(context,
                                  screen: FirebaseAuth.instance.currentUser!.uid
                                              .toString() ==
                                          document['id'].toString()
                                      ? ProfilePage()
                                      : OtherProfile(
                                          searchID: document['id'].toString(),
                                        )),
                              child: ListTile(
                                title: Text(document['username']),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(document['avatarUrl']),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                    }
                  },
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
