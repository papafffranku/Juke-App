import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget miniPlayer(String albumArt, String songName, String artistName){
  return
    Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.elliptical(35, 35))

        ),
        child:
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(albumArt),
                    radius: 30,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songName, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        artistName, style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ],
              ),
                  Row(
                  children: [

                    IconButton(splashColor: Colors.transparent,icon: Icon(Icons.pause, color: Colors.white, size:30),
                    onPressed: (){},),
                    IconButton(splashColor: Colors.transparent,icon: Icon(Icons.skip_next_rounded, color: Colors.white, size:30,),
                    onPressed:(){}),
                    SizedBox(width: 5),
                  ],
                  )],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ],
            )
          ],
        ),
      ),
    );
}