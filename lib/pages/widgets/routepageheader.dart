import 'package:flutter/material.dart';
import 'package:lessgoo/pages/chat/chat_search.dart';

AppBar routePageAppBar(
    {required BuildContext context, required IconData? icon, function}) {
  return AppBar(
    backgroundColor: Theme.of(context).backgroundColor,
    automaticallyImplyLeading: false,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(onPressed: function, icon: Icon(icon)),
      )
    ],
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios)),
  );
}

Widget routeHeader({required String title}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    ),
  );
}
