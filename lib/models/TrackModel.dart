import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/player/player.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../main.dart';

class Track extends StatefulWidget {
  final String id;
  final String Artist;
  final String SongDesc;
  final String SongName;
  final String coverLink;
  final String songLink;
  final dynamic likes;

  Track(
      {required this.id,
      required this.Artist,
      required this.SongDesc,
      required this.SongName,
      required this.coverLink,
      required this.songLink,
      required this.likes});

  factory Track.fromDocument(DocumentSnapshot doc) {
    return Track(
      id: doc['id'],
      Artist: doc['Artist'],
      SongDesc: doc['SongDesc'],
      SongName: doc['SongName'],
      coverLink: doc['coverLink'],
      songLink: doc['songLink'],
      likes: doc['likes'],
    );
  }

  int getLikeCount(likes) {
    //if no Likes
    if (likes == 0) {
      return 0;
    }

    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  _TrackState createState() => _TrackState(
      Artist: this.Artist,
      coverLink: this.coverLink,
      id: this.id,
      SongDesc: this.SongDesc,
      songLink: this.songLink,
      SongName: this.SongName,
      likes: this.likes,
      likeCount: getLikeCount(this.likes));
}

class _TrackState extends State<Track> {
  final String id;
  final String Artist;
  final String SongDesc;
  final String SongName;
  final String coverLink;
  final String songLink;
  int likeCount;
  Map likes;
  late bool isLiked;

  _TrackState(
      {required this.id,
      required this.Artist,
      required this.SongDesc,
      required this.SongName,
      required this.coverLink,
      required this.songLink,
      required this.likeCount,
      required this.likes});

  handletrackLikes() {
    bool _isLiked = likes[currentUserId] == true;

    if (_isLiked) {
      //Liked
      tracksRef
          .doc(Artist)
          .collection('publicSong')
          .doc(id)
          .update({'likes.$currentUserId': false});
      removeLikeFromActivityFeed();
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      //notLiked
      tracksRef
          .doc(Artist)
          .collection('publicSong')
          .doc(id)
          .update({'likes.$currentUserId': true});
      addLikeToActivityFeed();
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
      });
    }
  }

  removeLikeFromActivityFeed() {
    bool isNotPostOwner = currentUserId != Artist;
    if (isNotPostOwner) {
      activityfeedRef
          .doc(Artist)
          .collection("feedItems")
          .doc(id)
          .get()
          .then((doc) => {
                if (doc.exists) {doc.reference.delete()}
              });
    }
  }

  addLikeToActivityFeed() {
    //notification only when activity by another user and not self
    bool isNotPostOwner = currentUserId != Artist;
    if (isNotPostOwner) {
      activityfeedRef.doc(Artist).collection("feedItems").doc(id).set({
        "type": "like",
        "username": currentUserId,
        "postId": id,
      });
    }
  }

  Widget trackTile(String songUrl, String trackname, String artistname,
      String coverart, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 8, bottom: 5),
      child: InkWell(
        child: Container(
          child: Row(children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                    image: NetworkImage(coverart),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                pushNewScreen(context,
                    withNavBar: false,
                    screen: Player(
                        player: audioPlayer,
                        playlist: ConcatenatingAudioSource(children: [
                          AudioSource.uri(Uri.parse(songUrl),
                              tag: MediaItem(
                                  id: '1',
                                  title: trackname,
                                  artist: artistname,
                                  artUri: Uri.parse(coverart)))
                        ])));
              },
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trackname,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      artistname,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 14,
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: handletrackLikes,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                      color: isLiked
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                    )),
              ],
            ),
          ]),
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return trackTile(songLink, SongName, Artist, coverLink, context);
  }
}
