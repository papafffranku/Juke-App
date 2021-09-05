import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/methods/database.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _search = TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot? searchSnapshot;

  Widget searchList() {
    // ignore: unnecessary_null_comparison
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                  userName: searchSnapshot!.docs[index]['username']);
            })
        : Container(
            child: Text('no results found'),
          );
  }

  onSearch() async {
    searchList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search.addListener(onSearch);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _search.removeListener(onSearch);
    _search.dispose();
    super.dispose();
  }

  void initiateSearch() {
    databaseMethods.getUserByUsername(_search.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: TextField(
                        controller: _search,
                        textInputAction: TextInputAction.search,
                        style: TextStyle(fontSize: 35),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          initiateSearch();
                        },
                        icon: Icon(Icons.clear, size: 35))
                  ],
                ),
                SizedBox(height: 15),
                _search.text == ''
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Recent searches',
                          style: TextStyle(fontSize: 18, color: Colors.white54),
                        ))
                    : searchList(),
              ],
            ),
          ),
        ));
  }
}

class SearchTile extends StatelessWidget {
  final String userName;

  SearchTile({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 20),
              )
            ],
          )
        ],
      ),
    );
  }
}
