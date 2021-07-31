import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget Bio(String data) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('About',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      Card(
        color: Color(0xff5338FF).withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            data,
            style: TextStyle(
                color: Colors.white70, fontSize: 15),
          ),
        ),
      ),
    ],
  );
}