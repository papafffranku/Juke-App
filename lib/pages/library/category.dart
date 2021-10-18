import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/home/tools/track_tile.dart';
import 'package:lessgoo/pages/library/categories/librarytracks.dart';

class TracksPage extends StatefulWidget {
  final int selectedOption;
  const TracksPage({Key? key, required this.selectedOption}) : super(key: key);

  @override
  _TracksPageState createState() => _TracksPageState();
}

class _TracksPageState extends State<TracksPage> {
  late TabController _tabController;
  List<String> categories = ['Tracks', 'Albums', 'Artists'];
  List<Widget> underDisplay = [Tracks()];
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_tabController = TabController(length: 3, vsync: this);
    selectedIndex = widget.selectedOption;
  }

  Icon searchIcon = Icon(CupertinoIcons.search);
  Widget searchBar = Text('');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              title: searchBar,
              leading: Icon(Icons.arrow_back_ios_sharp),
              elevation: 5.0,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (this.searchIcon.icon == CupertinoIcons.search) {
                          this.searchIcon = Icon(CupertinoIcons.clear);
                          this.searchBar = TextField(
                            decoration:
                                InputDecoration(hintText: 'Search for tracks'),
                          );
                        } else {
                          this.searchIcon = Icon(CupertinoIcons.search);
                          this.searchBar = Text('');
                        }
                      });
                    },
                    icon: searchIcon)
              ],
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'home / library /',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white54),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'tracks',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '13324 tracks',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentColor,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.shuffle,
                                color: Colors.black,
                              ))),
                      SizedBox(width: 15),
                      IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {},
                          icon: Icon(Icons.sort_by_alpha)),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ))));
  }
}
