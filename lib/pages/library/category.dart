import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lessgoo/pages/library/categories/librarytracks.dart';

class CategoriesPage extends StatefulWidget {
  final int selectedOption;
  const CategoriesPage({Key? key, required this.selectedOption})
      : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> categories = ['Tracks', 'Albums', 'Artists'];
  List<Widget> underDisplay = [Tracks()];
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xff0e0e15),
            body: CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  title: Text('Library'),
                  backgroundColor: Color(0xff0e0e15),
                  pinned: true,
                  floating: true,
                  expandedHeight: 130,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const <StretchMode>[
                      StretchMode.blurBackground,
                    ],
                    background: Transform(
                      transform: Matrix4.translationValues(10.0, 50.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) =>
                                buildCategory(index)),
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(color: Color(0xff0e0e15), child: underDisplay[0])
                ]))
              ],
            )));
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(categories[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        selectedIndex == index ? Colors.white : Colors.white38,
                    fontSize: 30)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 3,
                width: 50,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? Colors.purpleAccent
                      : Colors.transparent,
                  //shape: BoxShape.circle
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
