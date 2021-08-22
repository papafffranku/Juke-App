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
                  trackTile('SLUGGER (feat. NOT & slowthai)', 'Kevin Abstract',
                      'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                  trackTile('Swing Lynn', 'Harmless',
                      'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                  trackTile('Corso', 'Tyler, The Creator',
                      'https://images.genius.com/9b50709a30fbb0eee802ba391af0eb43.999x999x1.png'),
                  trackTile('Weirdo', 'Fatter',
                      'https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/d5/30/4d/d5304d50-b5a4-db22-2db6-82019159ffd6/0.jpg/400x400bb.jpeg'),
                  trackTile('Feel Good Inc.', 'Gorillaz',
                      'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
                  trackTile('Green Grass', 'Ellie Dixon',
                      'https://is2-ssl.mzstatic.com/image/thumb/Music125/v4/1d/18/46/1d184666-be67-5f81-660a-a2b36b7f7c8b/195999965284.jpg/400x400cc.jpg'),
                  trackTile('SLUGGER (feat. NOT & slowthai)', 'Kevin Abstract',
                      'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                  trackTile('Swing Lynn', 'Harmless',
                      'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                  trackTile('Feel Good Inc.', 'Gorillaz',
                      'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
                  trackTile('SLUGGER (feat. NOT & slowthai)', 'Kevin Abstract',
                      'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                  trackTile('Swing Lynn', 'Harmless',
                      'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                  trackTile('Corso', 'Tyler, The Creator',
                      'https://images.genius.com/9b50709a30fbb0eee802ba391af0eb43.999x999x1.png'),
                  trackTile('Weirdo', 'Fatter',
                      'https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/d5/30/4d/d5304d50-b5a4-db22-2db6-82019159ffd6/0.jpg/400x400bb.jpeg'),
                  trackTile('Feel Good Inc.', 'Gorillaz',
                      'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
                  trackTile('Green Grass', 'Ellie Dixon',
                      'https://is2-ssl.mzstatic.com/image/thumb/Music125/v4/1d/18/46/1d184666-be67-5f81-660a-a2b36b7f7c8b/195999965284.jpg/400x400cc.jpg'),
                  trackTile('SLUGGER (feat. NOT & slowthai)', 'Kevin Abstract',
                      'https://static.stereogum.com/uploads/2021/07/Kevin-Abstract-Slugger-1626363400.jpeg'),
                  trackTile('Swing Lynn', 'Harmless',
                      'https://i1.sndcdn.com/artworks-000028655569-uk4f1a-t500x500.jpg'),
                  trackTile('Feel Good Inc.', 'Gorillaz',
                      'https://upload.wikimedia.org/wikipedia/en/d/df/Gorillaz_Demon_Days.PNG'),
                ],
              ),
            ))));
  }
}
