import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostPreview extends StatefulWidget {
  const PostPreview({Key? key}) : super(key: key);

  @override
  _PostPreviewState createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  VideoPlayerController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network('https://youtu.be/K9AtF6lKsnU')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller!.play());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column()),
    );
  }
}
