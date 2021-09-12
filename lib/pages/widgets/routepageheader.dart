import 'package:flutter/material.dart';

AppBar routePageAppBar(BuildContext context) {
  return AppBar(
    //backgroundColor: Theme.of(context).accentColor,
    automaticallyImplyLeading: false,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios)),
  );
}

Widget routeHeader(String title) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
