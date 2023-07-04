import 'package:aastu_ecsf/route/gallery/gallery_by_team.dart';
import 'package:aastu_ecsf/route/gallery/gallery_by_year.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class GalleryCardsInclude {
  static Widget get(BuildContext context) {
    Widget widget;
    widget = SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: Column(
          children: <Widget>[
            Container(height: 15),
            Row(children: <Widget>[
              Container(width: 3),
              Text("TEAMS",
                  style: MyText.medium(context).copyWith(
                      color: const Color.fromARGB(255, 255, 255, 255))),
            ]),
            Container(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByTeam(team: "I4U"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
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
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("I4U Events",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff808080))),
                                    Text("Charity Team",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff808080))),
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
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByTeam(team: "LAD"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            Img.get('ch9.jpg'),
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(height: 15),
                          Row(
                            children: <Widget>[
                              Container(width: 15),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("LAD Nights",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff808080))),
                                    Text("Literature Team",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff808080))),
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
                ),
              ],
            ),
            Container(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByTeam(team: "OutReach"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            Img.get('outreach.jpg'),
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(height: 15),
                          Row(
                            children: <Widget>[
                              Container(width: 15),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Outreach Team",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff808080))),
                                    Text("Spreading the gospel",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff808080))),
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
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByTeam(team: "Leaders"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            Img.get('leaders.jpg'),
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(height: 15),
                          Row(
                            children: <Widget>[
                              Container(width: 15),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Leaders Team",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff808080))),
                                    Text("Fellowship Leaders",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff808080))),
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
                ),
              ],
            ),
            Container(height: 15),
            Row(children: <Widget>[
              Container(width: 3),
              Text("BY YEAR",
                  style: MyText.medium(context).copyWith(
                      color: const Color.fromARGB(255, 255, 255, 255))),
            ]),
            Container(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByYear(year: "2015"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            Img.get('gallery_cover3.jpg'),
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: const Text("2015",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff808080)))),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByYear(year: "2014"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            Img.get('gallery_cover4.jpg'),
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: const Text("2014",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff808080)))),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByYear(year: "2013"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: const Text("2013",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff808080)))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByYear(year: "2012"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: const Text("2012",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff808080)))),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByYear(year: "2011"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: const Text("2011",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff808080)))),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryByYear(year: "2010"),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xff212121),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            Img.get('gallery_cover5.jpg'),
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: const Text("2010",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff808080)))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return widget;
  }
}
