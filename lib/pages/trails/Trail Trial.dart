import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class TextOverImage extends StatefulWidget {


  @override
  _TextOverImageState createState() => _TextOverImageState();
}

class _TextOverImageState extends State<TextOverImage> {

  @override
  void initState() {
    super.initState();
  }

  double _fontSize = 20;
  final double _baseFontSize = 20;
  double _fontScale = 1;
  double _baseFontScale = 1;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(child: Text('Trails hehe'),
            onTap: () async {await wtf();},),
      ),
      body: Center(
        child: Container(
          height: height*0.75,
          width: width-20,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: new NetworkImage(
                            "https://wallpaperaccess.com/full/3235185.jpg"),
                        fit: BoxFit.cover)),
              ),
              HomePage(),
              Container(
                height: 200,
                child: Center(
                  child: Text(
                    'title',
                    style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff11282c), Colors.black],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Color> getImagePalette (ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator
        .fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  Future<void> wtf() async {
    var abc=await getImagePalette(
        NetworkImage("https://wallpaperaccess.com/full/3235185.jpg"));
    print(abc);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset offset = Offset.zero;

  double _fontSize = 20;
  final double _baseFontSize = 20;
  double _fontScale = 1;
  double _baseFontScale = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                offset = Offset(
                    offset.dx + details.delta.dx, offset.dy + details.delta.dy);
              });
            },
            child: SizedBox(
              width: 300,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.black
                      ),
                      child: Text("Gotta kill itachi man, cant let him live",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                              color: Theme.of(context).accentColor)),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}