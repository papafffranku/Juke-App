import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget newsongwidget(String Im, String Sname, String artist, String year) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 15.0),
    child: Stack(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(Im),
              fit: BoxFit.none,
            ),
          ),
        ),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.75),
            borderRadius: BorderRadius.all(
                Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(12)),
                      image: DecorationImage(
                          image: NetworkImage(Im),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FEATURED SONG",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 22,
                            fontWeight:
                            FontWeight.w500),
                      ),
                      SizedBox(
                        width: 230,
                        child: Text(
                          Sname,
                          overflow:
                          TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            artist+' - '+year,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}