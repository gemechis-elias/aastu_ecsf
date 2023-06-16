import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class IncludeDrawerContent {
  static List<String> imagesPlaces = [
    "image_6.jpg",
    "image_2.jpg",
    "image_3.jpg",
    "image_4.jpg",
    "image_5.jpg",
  ];

  static List<String> titlePlaces = [
    "Praesent Maximus Nisl Metus, Vitae Imperdiet Eros",
    "Quisque Lobortis Massa Quis Augue Venenatis",
    "In Lobortis Aliquet Rutrum, Praesent Eget",
    "Cras Finibus Tortor Quis Fermentum Suscipit",
    "Aenean Eleifend Lorem Nec Posuere",
  ];

  static Widget get(BuildContext context) {
    Widget widget;
    List<Widget> items = [];
    for (int i = 0; i < imagesPlaces.length; i++) {
      Widget w = Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  Img.get(imagesPlaces[i]),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Container(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(titlePlaces[i],
                          style: MyText.medium(context).copyWith(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500)),
                      Container(height: 5),
                      Text("06 March 2019",
                          style: MyText.body1(context)!
                              .copyWith(color: Colors.grey[500])),
                      Container(height: 5),
                      Text(MyStrings.lorem_ipsum,
                          maxLines: 2,
                          style: MyText.subhead(context)!
                              .copyWith(color: Colors.grey[700])),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(height: 0, color: Colors.grey[300], thickness: 0.5)
        ],
      );
      items.add(w);
    }

    widget = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: items,
      ),
    );
    return widget;
  }
}
