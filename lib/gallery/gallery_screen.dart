import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';

import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/included/include_store_simple.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

import '../home_screen/design_course_app_theme.dart';

class SearchCityRoute extends StatefulWidget {
  SearchCityRoute();

  @override
  SearchCityRouteState createState() => new SearchCityRouteState();
}

class SearchCityRouteState extends State<SearchCityRoute> {
  bool isSwitched1 = true;
  bool finishLoading = true;
  final TextEditingController inputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_3,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 18, right: 16),
              child: Text(
                'Gallery',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  letterSpacing: 0.27,
                  color: HomeScreenAppTheme.darkerText,
                ),
              ),
            ),
            SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    Img.get('fello_1.jpg'),
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "General Fellowship Gallery",
                          style:
                              TextStyle(fontSize: 24, color: Colors.grey[800]),
                        ),
                        Container(height: 10),
                        Container(
                          child: Text(
                              "Explore images of our fellowship events of all batches",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700])),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 8),
                      TextButton(
                        style:
                            TextButton.styleFrom(primary: Colors.transparent),
                        child: Text(
                          "EXPLORE",
                          style:
                              TextStyle(color: Color.fromARGB(255, 4, 93, 137)),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Container(height: 5)
                ],
              ),
            ),
            Container(height: 5),
            Card(
              child: IncludeStoreSimple.get(context),
            ),
          ],
        ),
      ),
    );
  }
}
