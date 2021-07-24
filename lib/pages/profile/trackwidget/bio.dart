import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget Bio() {
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
            "Control can sometimes be an illusion. But sometimes you need illusions to gain control. Fantasy is an easy way to give meaning to world. To cloak our harsh reality with escapist comfort. ",
            style: TextStyle(
                color: Colors.white70, fontSize: 15),
          ),
        ),
      ),
    ],
  );
}