import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ModalScreens{

  void loadingmodalscreen(BuildContext context) {
    double screenheight=MediaQuery. of(context). size. height;

    showModalBottomSheet(isDismissible:false,context: context, builder: (BuildContext bc){
      return Container(
        color: CupertinoColors.black,
        height: screenheight * .80,
        child: Column(
          children: [
            SizedBox(height: 15,),
            Shimmer.fromColors(
              baseColor: CupertinoColors.systemBlue,
              highlightColor: Colors.lightBlue,
              child: Icon(Icons.cloud_upload_rounded,
                color: Colors.blue,
                size: 120,),
            ),
            SizedBox(height: 5,),
            Text("Hang on, we're still uploading....",
              style: TextStyle(
                  color: Colors.lightBlueAccent[100],
                  fontSize: 18
              ),),
            Text("This takes about 1-2 minutes",
              style: TextStyle(
                  color: Colors.lightBlueAccent[100],
                  fontSize: 16
              ),),
            SizedBox(height: 30,),
            SizedBox(
              width: 250,
              child: LinearProgressIndicator(
                color: CupertinoColors.systemBlue,
              ),
            ),
          ],
        ),
      );
    });
  }

  void successmodalscreen(BuildContext context) {
    double screenheight=MediaQuery. of(context). size. height;

    showModalBottomSheet(isDismissible:false,context: context, builder: (BuildContext bc){
      return Container(
        color: CupertinoColors.black,
        height: screenheight * .80,
        child: Column(
          children: [
            SizedBox(height: 15,),
            Shimmer.fromColors(
              baseColor: CupertinoColors.systemBlue,
              highlightColor: Colors.lightBlue,
              child: Icon(Icons.cloud_upload_rounded,
                color: Colors.blue,
                size: 120,),
            ),
            SizedBox(height: 5,),
            Text("Hang on, we're still uploading....",
              style: TextStyle(
                  color: Colors.lightBlueAccent[100],
                  fontSize: 18
              ),),
            Text("This takes about 1-2 minutes",
              style: TextStyle(
                  color: Colors.lightBlueAccent[100],
                  fontSize: 16
              ),),
            SizedBox(height: 30,),
            SizedBox(
              width: 250,
              child: LinearProgressIndicator(
                color: CupertinoColors.systemBlue,
              ),
            ),
          ],
        ),
      );
    });
  }

}