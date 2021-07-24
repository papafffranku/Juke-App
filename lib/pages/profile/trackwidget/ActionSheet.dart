import 'package:flutter/cupertino.dart';

class ActionSheet{
  Widget CupertinoAction(){
    return CupertinoActionSheet(
      title: Text('No Way this works'),
      message: Text('ill bet'),
      actions: [
        CupertinoActionSheetAction(
            onPressed: (){

            },
            child: Text('Set as featured song'),
            isDefaultAction:true,
        ),
        CupertinoActionSheetAction(
          onPressed: (){

          },
          child: Text('View Privacy'),
        ),
        CupertinoActionSheetAction(
            onPressed: (){

            },
            isDestructiveAction:true,
            child: Text('Delete')
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        onPressed: (){},
      ),
    );
  }
}