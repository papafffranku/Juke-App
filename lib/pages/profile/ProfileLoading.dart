import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoading extends StatefulWidget {
  const ProfileLoading({Key? key}) : super(key: key);

  @override
  _ProfileLoadingState createState() => _ProfileLoadingState();
}

class _ProfileLoadingState extends State<ProfileLoading> {
  @override
  Widget build(BuildContext context) {
    double screenheight=MediaQuery. of(context). size. height;
    double screenwidth=MediaQuery. of(context). size. width;

    return ColorfulSafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0e0e15),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Color(0xff1c1c2a),
                  highlightColor: Colors.grey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 150,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 100,
                                height: 10,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: screenwidth-50,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.white,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 250,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 150,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 200,
                                height: 10,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.white,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 250,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 150,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 200,
                                height: 10,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.white,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 250,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 150,
                                height: 10,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 200,
                                height: 10,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 100,
                        width: screenwidth-50,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
