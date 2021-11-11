import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lessgoo/pages/home/home.dart';
import 'package:lessgoo/pages/player/player.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../main.dart';

class TrackTimeline extends StatefulWidget {
  final String id;
  final String Artist;
  final String SongDesc;
  final String SongName;
  final String coverLink;
  final String songLink;
  final dynamic likes;

  TrackTimeline(
      {required this.id,
      required this.Artist,
      required this.SongDesc,
      required this.SongName,
      required this.coverLink,
      required this.songLink,
      required this.likes});

  factory TrackTimeline.fromDocument(DocumentSnapshot doc) {
    return TrackTimeline(
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
  _TrackTimelineState createState() => _TrackTimelineState(
      Artist: this.Artist,
      coverLink: this.coverLink,
      id: this.id,
      SongDesc: this.SongDesc,
      songLink: this.songLink,
      SongName: this.SongName,
      likes: this.likes,
      likeCount: getLikeCount(this.likes));
}

class _TrackTimelineState extends State<TrackTimeline> {
  final String id;
  final String Artist;
  final String SongDesc;
  final String SongName;
  final String coverLink;
  final String songLink;
  int likeCount;
  Map likes;
  late bool isLiked;

  _TrackTimelineState(
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

  Widget releaseBlock(String imgUrl, String profilePic, String artistName,
      String name, String songUrl) {
    bool selected = true;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imgUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(profilePic),
                      ),
                      SizedBox(height: 10),
                      RotatedBox(
                          quarterTurns: 1,
                          child: Text(artistName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 50),
            child: Row(
              children: [
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    selected = !selected;

                    pushNewScreen(context,
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                        screen: Player(
                            player: audioPlayer,
                            playlist: ConcatenatingAudioSource(children: [
                              AudioSource.uri(Uri.parse(songLink),
                                  tag: MediaItem(
                                      id: '1',
                                      title: name,
                                      artist: artistName,
                                      artUri: Uri.parse(imgUrl)))
                            ])));
                  },
                  icon: Icon(
                      selected
                          ? Icons.play_circle_fill_rounded
                          : Icons.pause_circle_filled_rounded,
                      size: 40),
                ),
                SizedBox(width: 10),
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
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return releaseBlock(coverLink, coverLink, Artist, SongName, songLink);
  }
}
