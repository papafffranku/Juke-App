import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  final Timestamp timestamp;
  final dynamic likes;

  Track(
      {required this.id,
      required this.Artist,
      required this.SongDesc,
      required this.SongName,
      required this.coverLink,
      required this.songLink,
      required this.timestamp,
      required this.likes});

  factory Track.fromDocument(DocumentSnapshot doc) {
    return Track(
      id: doc['id'],
      Artist: doc['Artist'],
      SongDesc: doc['SongDesc'],
      SongName: doc['SongName'],
      coverLink: doc['coverLink'],
      songLink: doc['songLink'],
      timestamp: doc['timestamp'],
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
      timestamp: this.timestamp,
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
  final Timestamp timestamp;
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
      required this.timestamp,
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
      removeLikedTrack();
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
      addToLikedTracks();
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

  removeLikedTrack() {
    libraryRef
        .doc(currentUserId)
        .collection('likedTracks')
        .doc(id)
        .get()
        .then((doc) => {
              if (doc.exists) {doc.reference.delete()}
            });
  }

  addLikeToActivityFeed() {
    //notification only when activity by another user and not self
    bool isNotPostOwner = currentUserId != Artist;
    if (isNotPostOwner) {
      activityfeedRef.doc(Artist).collection("feedItems").doc(id).set({
        "type": "like",
        "userId": currentUserId,
        "trackId": id,
        'timestamp': Timestamp.now(),
        "mediaUrl": coverLink
      });
    }
  }

  addToLikedTracks() {
    //adds to users liked tracks
    libraryRef.doc(currentUserId).collection('likedTracks').doc(id).set({
      "trackId": id,
      'timestamp': Timestamp.now(),
      'mediaUrl': coverLink,
      'artist': Artist
    });
  }

  deletePost() async {
    tracksRef
        .doc(currentUserId)
        .collection('publicSong')
        .doc(id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    QuerySnapshot activityfeedSnapshot = await activityfeedRef
        .doc(currentUserId)
        .collection('feedItems')
        .where('trackId', isEqualTo: id)
        .get();

    activityfeedSnapshot.docs.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  trackModalMenu(BuildContext context, bool isUser) {

    final tracksRef = FirebaseFirestore.instance.collection('tracks');
    final usersRef = FirebaseFirestore.instance.collection('users');

    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              isUser
                  ? ListTile(
                      leading: Icon(CupertinoIcons.delete),
                      title: Text('Set as featured'),
                      onTap: () async {
                        await usersRef.doc(currentUserId).update({"featured": id});
                        Navigator.pop(context);
                      },
                    )
                  : SizedBox(),
              isUser
                  ? ListTile(
                      leading: Icon(CupertinoIcons.delete),
                      title: Text('Delete'),
                      onTap: () {
                        Navigator.pop(context);
                        deletePost();
                      },
                    )
                  : ListTile(
                      leading: Icon(
                        Icons.report,
                        color: Colors.red,
                      ),
                      title: Text('Report'),
                      onTap: () {},
                    )
            ],
          );
        });
  }

  Widget trackTile(
      String songUrl, String trackname, String artistname, String coverart) {
    bool isUser = currentUserId == artistname;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 8, bottom: 5),
      child: FutureBuilder<DocumentSnapshot>(
          future: userRef.doc(artistname).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                width: MediaQuery.of(context).size.width,
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
                  Expanded(
                    child: GestureDetector(
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
                                          artist: data['username'],
                                          artUri: Uri.parse(coverart)))
                                ])));
                      },
                      child: Container(
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
                            Container(
                              child: Text(
                                data['username'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: handletrackLikes,
                            splashColor: Colors.transparent,
                            child: Icon(
                              isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: isLiked
                                  ? Theme.of(context).accentColor
                                  : Colors.white,
                            )),
                        InkWell(
                            onTap: () {
                              trackModalMenu(context, isUser);
                            },
                            splashColor: Colors.transparent,
                            child: Icon(
                              Icons.more_vert_rounded,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ]),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return trackTile(songLink, SongName, Artist, coverLink);
  }
}
