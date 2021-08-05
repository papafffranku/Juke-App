import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ModalScreens {
  void loadingmodalscreen(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
        isDismissible: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.1, 0.9],
                    colors: [Colors.blue, Colors.transparent])),
            height: screenheight * .80,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: FlareActor(
                    'lib/assets/MusicLoad.flr',
                    animation: 'searching',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Hang on, we're still uploading....",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[100], fontSize: 18),
                ),
                Text(
                  "This takes about 1-2 minutes",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[100], fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  child: LinearProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
