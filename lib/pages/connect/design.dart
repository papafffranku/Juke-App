import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class Design extends StatefulWidget {
  const Design({Key? key}) : super(key: key);

  @override
  State<Design> createState() => _DesignState();
}

class _DesignState extends State<Design> {
  @override
  Widget build(BuildContext context) {
    List<String> strs = [
      "Hari Prasad Chaudhary",
      "Krishna Chaudhary",
      "John Cena",
      "Jonney Deep",
      "Clint Eastwood"
    ];
    return Scaffold(
        body: Swiper(
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 50,
            ),
            tags(strs)
          ],
        );
      },
      autoplay: false,
      itemCount: 10,
      scrollDirection: Axis.vertical,
      pagination: const SwiperPagination(alignment: Alignment.centerRight),
      control: const SwiperControl(),
    ));
  }
}

Widget tags(List strs){
  return Container(
    width: 300,
    height: 45,
    color: Colors.blue,
    child: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: strs.map((strone) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green[100],
              ),
              child: Text(strone),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),

            );
          }).toList(),
        )),
  );
}
