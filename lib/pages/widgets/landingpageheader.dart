import 'package:flutter/material.dart';
import 'package:lessgoo/pages/explore/SearchPage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Widget landingPageHeader(BuildContext context, String title, var actionButton) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          actionButton != false
              ? IconButton(
                  onPressed: () {
                    pushNewScreen(context, screen: SearchPage());
                  },
                  icon: Icon(
                    actionButton,
                    size: 35,
                  ))
              : SizedBox()
        ],
      ),
    ),
  );
}
