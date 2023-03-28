import 'package:aastu_ecsf/home_screen/design_course_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class AboutCompanyCardRoute extends StatefulWidget {
  AboutCompanyCardRoute();

  @override
  AboutCompanyCardRouteState createState() => new AboutCompanyCardRouteState();
}

class AboutCompanyCardRouteState extends State<AboutCompanyCardRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0, left: 18, right: 16),
                child: Text(
                  'About Us',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                    letterSpacing: 0.27,
                    color: HomeScreenAppTheme.darkerText,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Our Team",
                            style: MyText.medium(context).copyWith(
                                color: MyColors.grey_90,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Container(
                              width: 30,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 4, 93, 137),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          Img.get('photo_male_2.jpg')),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Gemechis Elias",
                                      style: MyText.caption(context)!.copyWith(
                                          color: MyColors.grey_90,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Mobile App Engineer",
                                      style: MyText.caption(context)!.copyWith(
                                          color: MyColors.grey_60,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          Img.get('photo_male_3.jpg')),
                                    ),
                                    Container(height: 8),
                                    Text("Getabalew Asfaw",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                color: MyColors.grey_90,
                                                fontWeight: FontWeight.w600)),
                                    Container(height: 4),
                                    Text("Graphics Designer",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                color: MyColors.grey_60,
                                                fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          Container(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("About",
                              style: MyText.medium(context).copyWith(
                                  color: MyColors.grey_90,
                                  fontWeight: FontWeight.w500)),
                          Container(height: 5),
                          Center(
                            child: Container(
                                width: 30,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 4, 93, 137),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                          ),
                          Container(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                                "Welcome to AASTU Christian Students Fellowship! We are a community of evangelical students at our college who come together to share our faith, support one another, and make a difference on campus.  \n\nOur goal is to provide a safe and welcoming environment for all students to explore and deepen their relationship with God. We invite you to join us for weekly Bible studies, worship, and fellowship events.",
                                textAlign: TextAlign.justify,
                                style: MyText.body2(context)!.copyWith(
                                  color: MyColors.grey_60,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Address",
                              style: MyText.medium(context).copyWith(
                                  color: MyColors.grey_90,
                                  fontWeight: FontWeight.w500)),
                          Container(height: 5),
                          Center(
                            child: Container(
                                width: 30,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 4, 93, 137),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                          ),
                          Container(height: 15),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(Img.get('image_maps.jpg'),
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover),
                                Container(height: 15),
                                Text("AASTU, Kilnto Mekaneyesus.",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: MyColors.grey_60)),
                                Text("Addis Ababa, Ethiopia",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: MyColors.grey_60)),
                                Text("Zip: 1000",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: MyColors.grey_60)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
