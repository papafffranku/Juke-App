import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget trackTile(String trackname, String artistname, String coverart) {
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
