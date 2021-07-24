import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  final int selectedOption;
  const CategoriesPage({Key? key, required this.selectedOption})
      : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> categories = ['Tracks', 'Albums', 'Artists'];
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
          appBar: AppBar(
            title: Text('Library'),
            backgroundColor: Color(0xff0e0e15),
          ),
          body: Container(
              color: Color(0xff0e0e15),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) => buildCategory(index)),
                  ),
                ],
              ))),
    );
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 6,
                width: 100,
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.purpleAccent.withOpacity(0.6)
                        : Colors.transparent,
                    shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
