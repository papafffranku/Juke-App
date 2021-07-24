import 'package:flutter/material.dart';

Widget albumTile(String coverArt, String albumName,String year) {
  return 
    Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(image: NetworkImage(coverArt),
            ),
          )),
        SizedBox(height: 10),
        Text(albumName, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
        //SizedBox(height: 10),
        Text(year, style: TextStyle(color: Colors.white54,fontSize: 13),),

      ],
    );
}