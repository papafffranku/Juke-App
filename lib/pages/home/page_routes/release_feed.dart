import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lessgoo/pages/home/page_routes/image_data.dart';
import 'package:lessgoo/pages/widgets/routepageheader.dart';
import 'package:transparent_image/transparent_image.dart';

class ReleaseFeed extends StatefulWidget {
  const ReleaseFeed({Key? key}) : super(key: key);

  @override
  _ReleaseFeedState createState() => _ReleaseFeedState();
}

class _ReleaseFeedState extends State<ReleaseFeed> {
  List<String> imageList = [
    'https://m.media-amazon.com/images/I/91mDjSqe2kL._SS500_.jpg',
    'https://upload.wikimedia.org/wikipedia/en/c/c1/The_Weeknd_-_After_Hours.png',
    'https://media.pitchfork.com/photos/5955049f4e56733c34fa8f9e/2:1/w_1000/600x600bb-1.jpg',
    'https://i1.sndcdn.com/artworks-000416506440-1rsz0m-t500x500.jpg',
    'https://graphicriver.img.customer.envatousercontent.com/files/264102893/brainwash-albumcover-template-preview.jpg?auto=compress%2Cformat&fit=crop&crop=top&w=590&h=590&s=5201f83eeedc67483d4e2a14dea00ee3',
    'https://media.architecturaldigest.com/photos/5890e88033bd1de9129eab0a/1:1/w_870,h_870,c_limit/Artist-Designed%20Album%20Covers%202.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: routePageAppBar(context, 'Releases'),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        return tileDisplay(imageList[index]);
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(1, index.isEven ? 1 : 1.5);
                      }),
                ),
              ),
            ),
          ],
        ));
  }

  Widget tileDisplay(String img) {
    return Container(
      decoration: BoxDecoration(),
      child: Stack(children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: img,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  )),
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  'Gimme Love \nJoji',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              )),
        )
      ]),
    );
  }
}
