import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class IncludeStoreSimple {
  static Widget get(BuildContext context) {
    Widget widget;
    widget = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: Column(
          children: <Widget>[
            Container(height: 15),
            Row(children: <Widget>[
              Container(width: 3),
              Text("TEAMS",
                  style:
                      MyText.medium(context).copyWith(color: Colors.grey[800])),
            ]),
            Container(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('fello_4.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("I4U Events",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[900])),
                                  Text("Charity Team",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[500])),
                                ],
                              ),
                            ),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('fello_8.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Worship Nights",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[900])),
                                  Text("Worship & Choir",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[500])),
                                ],
                              ),
                            ),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 15),
            Row(children: <Widget>[
              Container(width: 3),
              Text("BY YEAR",
                  style:
                      MyText.medium(context).copyWith(color: Colors.grey[800])),
            ]),
            Container(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('fello_5.jpg'),
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Text("2011",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[900]))),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('fello_6.jpg'),
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Text("2012",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[900]))),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('fello_7.jpg'),
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Text("2013",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[900]))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 15),
            Row(children: <Widget>[
              Container(width: 3),
              Text("TEAMS",
                  style:
                      MyText.medium(context).copyWith(color: Colors.grey[800])),
            ]),
            Container(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_2.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Suspendisse ornare",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[900])),
                                  Text("Adipiscing",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[500])),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert,
                                color: Colors.grey[500], size: 25),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_5.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Placerat vel ipsum",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[900])),
                                  Text("amet rutrum",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[500])),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert,
                                color: Colors.grey[500], size: 25),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 15),
          ],
        ),
      ),
    );
    return widget;
  }
}
