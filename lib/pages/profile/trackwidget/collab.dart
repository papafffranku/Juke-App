import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget Collabs(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff5338FF),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.group,size: 35,color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Collaborated with',style: TextStyle(color: Colors.white,fontSize: 16),),
                          Text('25 users',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              ProfileCluster(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlueAccent,
                size: 25,
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget ProfileCluster(){
  return Container(
    //color: Colors.black,
    width: 150,
    child: Stack(
      //alignment:new Alignment(x, y)
      children: <Widget>[
        Positioned(left:80,child: CollabPro()),
        Positioned(left:40, child: CollabPro()),
        CollabPro(),
      ],
    ),
  );
}

Widget CollabPro(){
  String Profile = 'https://www.nicepng.com/png/detail/627-6278749_at-the-movies-elliot-alderson.png';
  return CircleAvatar(
    radius: 28,
    backgroundImage: NetworkImage(Profile),
    backgroundColor: Colors.transparent,
  );
}