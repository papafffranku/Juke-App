import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget trackTile(
    String trackname, String artistname, int plays, String coverart) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 5),
    child: InkWell(
      child: Container(
        child: Row(children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: DecorationImage(
                  image: NetworkImage(coverart),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 10),
          Expanded(
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
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
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

String playsToString(int plays) {
  int n = plays.toString().length;
  String notif = '';
  String res = '';
  if (n < 4) {
    return plays.toString();
  } else if (n < 6) {
    notif = 'K';
  } else if (n < 9) {
    notif = 'M';
  }

  res = plays.toString().substring(0, 3);
  if (res.length != 1) {
    res = res[0] + '.' + res.substring(1);
  }

  return res + notif;
}
