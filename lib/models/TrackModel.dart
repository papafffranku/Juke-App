class Track {
  final String title;
  final String imgUrl;
  final String artist;
  final String url;
  bool playing;
  Track(
      {required this.title,
      required this.imgUrl,
      required this.artist,
      required this.url,
      this.playing = false});
}
