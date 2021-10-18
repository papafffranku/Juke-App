import 'package:flutter/material.dart';
import 'package:lessgoo/pages/widgets/landingpageheader.dart';
import 'package:lessgoo/pages/widgets/routepageheader.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Column(
            children: [
              landingPageHeader(context, 'Channels', false, false),
              TabBar(tabs: [
                Tab(
                  child: Text('All'),
                ),
                Tab(
                  child: Text('Joined'),
                )
              ]),
              SizedBox(height: 15),
              Expanded(
                child: Container(
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          GroupTile(),
                        ],
                      ),
                      Column(
                        children: [
                          GroupTile(),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ))),
    );
  }
}

class GroupTile extends StatelessWidget {
  const GroupTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff0d0d0d),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width - 20,
      height: 170,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'feedback',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Get feedback on your ideas or give feedbacks to other tracks.',
              style: TextStyle(color: Colors.white54),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      '34k',
                      style: TextStyle(),
                    ),
                    Text(
                      'members',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    )
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      '102',
                      style: TextStyle(),
                    ),
                    Text(
                      'posts',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    )
                  ],
                ),
                Spacer(),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).accentColor)),
                    onPressed: () {},
                    child: Text(
                      '+ Join',
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 16),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
