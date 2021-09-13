import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/models/TrailModel.dart';
import 'package:lessgoo/pages/home/page_routes/page_preview.dart';
import 'package:lessgoo/pages/home/page_routes/trail_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  List<Trails> trailList = [
    Trails(
      artistName: 'Tame_Impala',
      imgUrl:
          'https://www.rollingstone.com/wp-content/uploads/2019/05/tame-impala-lead-photo.jpg',
    ),
    Trails(
      artistName: 'Kanye_West',
      imgUrl:
          'https://media.pitchfork.com/photos/60fabf372e77ffecd64d64ad/2:1/w_2560%2Cc_limit/Kanye-West.jpg',
    ),
    Trails(
      artistName: 'J.Cole',
      imgUrl:
          'https://i.scdn.co/image/ab6761610000e5ebadd503b411a712e277895c8a',
    ),
    Trails(
      artistName: 'Brockhampton',
      imgUrl:
          'https://media.newyorker.com/photos/607de09d8f675fab920cd1f1/1:1/w_1920,h_1920,c_limit/Pearce-BrockhamptonPandemic.jpg',
    ),
    Trails(
      artistName: 'Tame_Impalalalala',
      imgUrl:
          'https://www.rollingstone.com/wp-content/uploads/2019/05/tame-impala-lead-photo.jpg',
    ),
    Trails(
      artistName: 'Tame_Impala',
      imgUrl:
          'https://www.rollingstone.com/wp-content/uploads/2019/05/tame-impala-lead-photo.jpg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: ListView(
        children: [trailSection(), releaseSection()],
      )),
    );
  }

  Widget releaseSection() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Releases',
                style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        releaseBlock(
            'https://www.sleek-mag.com/wp-content/uploads/2016/08/AlbumCovers_Blonde-1200x1200.jpg',
            'https://miro.medium.com/max/640/1*HEvh6wLy-z4wwt9aEatUOw@2x.png',
            'Frank Ocean',
            'blond'),
        releaseBlock(
            'https://static.billboard.com/files/media/Young-Thug-Jeffery-2016-billboard-1240-compressed.jpg',
            'https://pbs.twimg.com/media/E9WZEsxXEAMw4vO.jpg',
            'Young Thug',
            'Twister Nightmares'),
        releaseBlock(
            'https://cdn.mos.cms.futurecdn.net/g6MkYufocsYc3ToH85v2th-970-80.jpg.webp',
            'https://pyxis.nymag.com/v1/imgs/c6a/835/176402f7714503041d300b0af28af3ec2e-beyonce-dj-khaled.rsquare.w1200.jpg',
            'Beyonce',
            'Lemonade'),
      ],
    );
  }

  Widget releaseBlock(
      String imgUrl, String profilePic, String artistName, String name) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => pushNewScreen(context, screen: PostPreview()),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                // CircleAvatar(
                //   radius: 20,
                //   backgroundImage: NetworkImage(profilePic),
                // ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'album',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    Text(
                      'by $artistName',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget trailSection() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trails',
                  style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "check what everyone's upto",
                  style: TextStyle(
                      letterSpacing: 1.3,
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              height: 110,
              child: ListView.builder(
                itemCount: trailList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        trailAvatar(trailList[index].imgUrl,
                            trailList[index].artistName)
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget trailAvatar(String imgurl, String artistName) {
    return Column(
      children: [
        Stack(children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            radius: 4,
          ),
          GestureDetector(
            onTap: () => pushNewScreen(context, screen: StoryPageView()),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imgurl),
              radius: 32,
            ),
          ),
        ]),
        SizedBox(height: 5),
        Container(
          width: 60,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    artistName.toLowerCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
