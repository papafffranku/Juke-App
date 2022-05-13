import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:lessgoo/pages/home/widgethome/newsongwidget.dart';

class newstuff extends StatefulWidget {
  const newstuff({Key? key}) : super(key: key);

  @override
  _newstuffState createState() => _newstuffState();
}

class _newstuffState extends State<newstuff> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('trial');

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          FutureBuilder<DocumentSnapshot>(
            future: users.doc('bru').get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    Text("Full Name: ${data['1'][0]}"),
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment(-0.8, 0.8),
                              colors: [
                                Colors.black,
                                Colors.transparent
                              ],
                              radius: 2.4,
                              stops: [0.005, 0.995],
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://media.architecturaldigest.com/photos/5890e88033bd1de9129eab0a/1:1/w_870,h_870,c_limit/Artist-Designed%20Album%20Covers%202.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment(-0.8, 0.8),
                              colors: [
                                Colors.blue,
                                Colors.transparent
                              ],
                              radius: 2.4,
                              stops: [0.005, 0.995],
                            ),
                          ),
                        ),
                        newsongwidget('https://media.architecturaldigest.com/photos/5890e88033bd1de9129eab0a/1:1/w_870,h_870,c_limit/Artist-Designed%20Album%20Covers%202.jpg', 'music west', 'kanye west', '2020')
                      ],
                    ),
                  ],
                );
              }
              return Text("loading");
            },
          ),
        ],
      ),
    );
  }
  mover(Map<String, dynamic> data123, String usernamenew, String trackidnew) async {
    CollectionReference users = FirebaseFirestore.instance.collection('trial');
    final DocumentSnapshot doc = await users.doc('bru1').get();

    Map<String, dynamic> changed={};
    for (int i=1;i<=5;i++){
      if(i==1){
        changed.addAll({
          '1' : ['$usernamenew','$trackidnew'],
        });
      }
      else{
        changed.addAll({
          '$i' : data123['${i-1}'],
        });
      }
      users.doc('bru1').update({
        "$i": changed['$i'],
      });
    }
    print(data123);
    print(changed);
  }
}
