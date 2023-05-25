import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutCompanyCardRoute extends StatefulWidget {
  AboutCompanyCardRoute();

  @override
  AboutCompanyCardRouteState createState() => new AboutCompanyCardRouteState();
}

class AboutCompanyCardRouteState extends State<AboutCompanyCardRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xff121212),
        centerTitle: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xffd1a552), Color.fromARGB(255, 209, 150, 82)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "About Us",
            style: TextStyle(
              fontFamily: 'MyBoldFont',
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 2,
                    color: const Color(0xff212121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Our Team",
                            style: MyText.medium(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: Container(
                              width: 30,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 4, 93, 137),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Developer_1();
                                        });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            Img.get('developer1.jpg')),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Gemechis Elias",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Mobile App Engineer",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                color: MyColors.grey_60,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Developer_2();
                                        });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            Img.get('developer2.jpg')),
                                      ),
                                      Container(height: 8),
                                      Text("Getabalew Asfaw",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.white70,
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
                    color: const Color(0xff212121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("About",
                              style: MyText.medium(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          Container(height: 5),
                          Center(
                            child: Container(
                                width: 30,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 4, 93, 137),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                          ),
                          Container(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(children: <Widget>[
                              Text(
                                "Welcome to AASTU Christian Students Fellowship! We are a community of evangelical students at our college who come together to share our faith, support one another, and make a difference on campus.  \n\nOur goal is to provide a safe and welcoming environment for all students to explore and deepen their relationship with God. We invite you to join us for weekly Bible studies, worship, and fellowship events.",
                                textAlign: TextAlign.justify,
                                style: MyText.body2(context)!.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                  Card(
                    elevation: 2,
                    color: const Color(0xff212121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Address",
                              style: MyText.medium(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          Container(height: 5),
                          Center(
                            child: Container(
                                width: 30,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 4, 93, 137),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                          ),
                          Container(height: 15),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                        .copyWith(color: Colors.white70)),
                                Text("Addis Ababa, Ethiopia",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: Colors.white70)),
                                Text("Zip: 1000",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: Colors.white70)),
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

  Future<void> _launchUrl(String s) async {
    log("Link Clicked ");
    final Uri _url = Uri.parse(s);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // ignore: non_constant_identifier_names
  Widget Developer_1() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 310,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: MyColors.grey_90,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.lightGreen[800]),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(Img.get("developer1.jpg")),
                    ),
                    Container(height: 10),
                    Text("Gemechis Elias",
                        textAlign: TextAlign.left,
                        style: MyText.headline(context)!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Container(height: 2),
                    Text("Developer",
                        textAlign: TextAlign.start,
                        style: MyText.body1(context)!
                            .copyWith(color: MyColors.grey_40)),
                    Container(height: 35),
                    Text("Experienced Developer in Mobile App Technologies",
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!
                            .copyWith(color: MyColors.grey_40)),
                  ],
                ),
              ),
              Container(height: 35),
              Divider(height: 0, color: Colors.lightGreen[800]),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Text("Check my social media",
                        textAlign: TextAlign.start,
                        style: MyText.body1(context)!
                            .copyWith(color: MyColors.grey_20)),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl("https://twitter.com/gemechis_");
                          },
                          child: Image.asset(Img.get("ic_social_twitter.png"),
                              height: 25, width: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl("https://realgemechis.t.me");
                          },
                          child: Image.asset(Img.get("ic_social_facebook.png"),
                              height: 25, width: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl("https://instagram.com/realgemechis");
                          },
                          child: Image.asset(Img.get("ic_social_instagram.png"),
                              height: 25, width: 25),
                        ),
                      ],
                    ),
                    Container(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget Developer_2() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 310,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: MyColors.grey_90,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.lightGreen[800]),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(Img.get("developer2.jpg")),
                    ),
                    Container(height: 10),
                    Text("Getabalew Asfaw",
                        textAlign: TextAlign.left,
                        style: MyText.headline(context)!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Container(height: 2),
                    Text("Developer",
                        textAlign: TextAlign.start,
                        style: MyText.body1(context)!
                            .copyWith(color: MyColors.grey_40)),
                    Container(height: 35),
                    Text("Experienced UI/UX Designer | Mechatronics Engineer",
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!
                            .copyWith(color: MyColors.grey_40)),
                  ],
                ),
              ),
              Container(height: 35),
              Divider(height: 0, color: Colors.lightGreen[800]),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Text("Check my social media",
                        textAlign: TextAlign.start,
                        style: MyText.body1(context)!
                            .copyWith(color: MyColors.grey_20)),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl("https://twitter.com/gemechis_");
                          },
                          child: Image.asset(Img.get("ic_social_twitter.png"),
                              height: 25, width: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl("https://realgemechis.t.me");
                          },
                          child: Image.asset(Img.get("ic_social_facebook.png"),
                              height: 25, width: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl("https://instagram.com/realgemechis");
                          },
                          child: Image.asset(Img.get("ic_social_instagram.png"),
                              height: 25, width: 25),
                        ),
                      ],
                    ),
                    Container(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
