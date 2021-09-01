import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _search = TextEditingController();

  onSearch() async {
    print('Hello');
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
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.clear, size: 35))
                  ],
                ),
                SizedBox(height: 15),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Recent searches',
                      style: TextStyle(fontSize: 18, color: Colors.white54),
                    ))
              ],
            ),
          ),
        ));
  }
}
