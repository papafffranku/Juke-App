import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/Reference/Persist.dart';
import 'package:flare_flutter/flare_actor.dart';

class SuccessUpload extends StatefulWidget {
  const SuccessUpload({Key? key}) : super(key: key);

  @override
  _SuccessUploadState createState() => _SuccessUploadState();
}

class _SuccessUploadState extends State<SuccessUpload> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0e0e15),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                child: Text("Toggle"),
                onPressed: () {
                  setState(() {
                    toggle = !toggle;
                  });
                },
              ),
              Container(
                height: 200,
                width: 200,
                child: toggle ? Loading() : Success(),
              ),
              Container(
                color: Colors.white10,
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Container(
                      height: 250,
                      width:250,
                      child: FlareActor(
                        'lib/assets/MusicLoad.flr',
                        animation: 'searching',
                        fit: BoxFit.contain,
                      ),
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
              )
            ],
          ),
        ));
  }

  Widget Loading() {
    return FlareActor(
      'lib/assets/MusicLoad.flr',
      animation: 'searching',
      fit: BoxFit.contain,
    );
  }

  Widget Success() {
    return FlareActor(
      'lib/assets/Success_Check.flr',
      animation: 'Untitled',
      fit: BoxFit.contain,
    );
  }
}
