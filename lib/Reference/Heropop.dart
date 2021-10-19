import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/PopUp/CustomRectTween.dart';

import '../PopUp/HeroDialogRoute.dart';

class Heropop extends StatefulWidget {
  const Heropop({Key? key}) : super(key: key);

  @override
  _HeropopState createState() => _HeropopState();
}

class _HeropopState extends State<Heropop> {
  String name = 'vikram sharma';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero animation"),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return const _AddTodoPopupCard();
                    }));
                  },
                  child: Hero(
                    tag: _heroAddTodo,
                    createRectTween: (begin, end) {
                      return CustomRectTween(begin: begin, end: end);
                    },
                    child: Material(
                      color: Colors.blue,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 56,
                      ),
                    ),
                  ),
                ),
                CupertinoButton.filled(
                  onPressed: () {
                    Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return const _AddTodoPopupCard();
                    }));
                  },
                  child: Text("Click"),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: Text(name),
                  onTap: () {
                    List arr = name.split('');
                    List arr1 = [];
                    String split = '';
                    List splitname = name.split(' ');
                    print(splitname);
                    for (int i = 0; i <= name.length - 1; i++) {
                      split = split + arr[i];
                      arr1.add(split);
                      print(arr1);
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Theme.of(context).accentColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Upload a ',
                                  style: TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Song',
                                  style: TextStyle(
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.black26),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Upload a ',
                                  style: TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Trail',
                                  style: TextStyle(
                                      letterSpacing: 1.2,
                                      color: Theme.of(context).accentColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class _AddTodoPopupCard extends StatelessWidget {
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.blue,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'New todo',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a note',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
