import 'package:flutter/material.dart';

AppBar routePageAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Theme.of(context).accentColor,
    title: Text(title),
    automaticallyImplyLeading: false,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios)),
  );
}

Widget routeHeader() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Releases',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
