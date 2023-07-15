import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AboutCompanyCardRoute extends StatefulWidget {
  const AboutCompanyCardRoute({super.key});
  @override
  AboutUsRouteState createState() => AboutUsRouteState();
}

class AboutUsRouteState extends State<AboutCompanyCardRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        elevation: 0,
        //   brightness: Brightness.dark,
        backgroundColor: const Color(0xff121212),
        centerTitle: false,
        automaticallyImplyLeading: false,
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
                                fontFamily: 'MyBlodFont',
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return gemechisDialog(
                                            "Gemechis Elias",
                                            "developer1.jpg",
                                            "Software Engineer",
                                            "Exprienced Software developer in Web and Mobile App Technologies",
                                            "https://www.linkedin.com/in/gemechis-elias/",
                                            "https://facebook.com/gemechis.m.elias",
                                            "https://instagram.com/realgemechis",
                                          );
                                        });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            Img.get('developer1.jpg')),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Gemechis Elias",
                                        maxLines: 1,
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                fontSize: 11,
                                                fontFamily: 'MyFont',
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "See profile",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                fontFamily: 'MyFont',
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
                                          return getabalewDialog(
                                            "Getabalew Asfaw",
                                            "developer2.jpg",
                                            "Mechatronics Engineer",
                                            "Web designer, UI/UX, Graphics designer",
                                            "https://twitter.com/getish_15?t=t3xBu8Rnzk3LZcfsH4l4-g&s=09",
                                            "https://instagram.com/getish.crtv?igshid=NGExMmI2YTkyZg==",
                                            "https://instagram.com/getish.crtv?igshid=NGExMmI2YTkyZg==",
                                          );
                                        });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            Img.get('developer2.jpg')),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Getabalew Asfaw",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                fontSize: 11,
                                                fontFamily: 'MyFont',
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "See profile",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                fontFamily: 'MyFont',
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
                                          return dagimDialog(
                                            "Dagmawi Esayas",
                                            "developer3.jpg",
                                            "Fullstack Engineer",
                                            "A random tech geek.",
                                            "https://t.me/Dagmawi_Babi",
                                            "https://www.tiktok.com/@dagmawi_babi?_t=8e0rYPz7G1F&_r=1",
                                            "https://instagram.com/dagmawibabi?igshid=NGExMmI2YTkyZg==",
                                          );
                                        });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            Img.get('developer3.jpg')),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Dagmawi Esayas",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                fontSize: 11,
                                                fontFamily: 'MyFont',
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "See profile",
                                        style: MyText.caption(context)!
                                            .copyWith(
                                                fontFamily: 'MyFont',
                                                color: MyColors.grey_60,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 20),
                          GestureDetector(
                            onTap: () {
                              _launchUrl(
                                  "https://telegra.ph/CONTRIBUTORS-AASTU-ECSF-MOBILE-APP-07-07");
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: '',
                                style: TextStyle(
                                  fontFamily: 'MyFont',
                                  color: Colors.black,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Icon(
                                        Icons.link,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Check out more contributors',
                                    style: TextStyle(
                                      fontFamily: 'MyFont',
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                  fontFamily: 'MyBoldFont',
                                  fontWeight: FontWeight.w500)),
                          Container(height: 5),
                          Container(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(children: <Widget>[
                              Text(
                                "Welcome to AASTU Christian Students Fellowship! We are a community of evangelical students at our college who come together to share our faith, support one another, and make a difference on campus.  \n\nOur goal is to provide a safe and welcoming environment for all students to explore and deepen their relationship with God. We invite you to join us for weekly Bible studies, worship, and fellowship events.",
                                //textAlign: TextAlign.justify,
                                style: MyText.body2(context)!.copyWith(
                                  fontFamily: 'MyFont',
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
                                  fontFamily: 'MyBoldFont',
                                  fontWeight: FontWeight.w500)),
                          Container(height: 5),
                          Container(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _launchUrl(
                                        "https://goo.gl/maps/FPTi55rR7n8P5ccx9");
                                  },
                                  child: Image.asset(Img.get('map.png'),
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                ),

                                Container(height: 15),
                                Text("AASTU, Kilnto Mekaneyesus.",
                                    style: MyText.subhead(context)!.copyWith(
                                        fontFamily: 'MyFont',
                                        color: Colors.white70)),
                                Text("Addis Ababa, Ethiopia",
                                    style: MyText.subhead(context)!.copyWith(
                                        fontFamily: 'MyFont',
                                        color: Colors.white70)),
                                Text("Zip: 1000",
                                    style: MyText.subhead(context)!.copyWith(
                                        fontFamily: 'MyFont',
                                        color: Colors.white70)),
                                Container(height: 5),
                                // list of horixontal icon
                                Center(
                                  child: SizedBox(
                                    width: double
                                        .infinity, // Optional: Adjust the height as needed
                                    // Optional: Set the background color of the parent widget
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors
                                                .transparent, // Set the text color to white
                                            elevation:
                                                0, // Remove the button's elevation
                                            padding: EdgeInsets
                                                .zero, // Remove the button's padding
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap, // Reduce the button's tap target size
                                            side: BorderSide
                                                .none, // Remove the button's border
                                          ),
                                          onPressed: () {
                                            // Handle facebook button pressed
                                            _launchUrl(
                                                "https://www.facebook.com/ecsf.aastu");
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.facebook,
                                                color: Colors.white,
                                                size: 30.0,
                                              ),
                                              SizedBox(width: 1),
                                            ],
                                          ),
                                        ),
                                        Container(height: 5),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors
                                                .transparent, // Set the text color to white
                                            elevation:
                                                0, // Remove the button's elevation
                                            padding: EdgeInsets
                                                .zero, // Remove the button's padding
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap, // Reduce the button's tap target size
                                            side: BorderSide
                                                .none, // Remove the button's border
                                          ),
                                          onPressed: () {
                                            // Handle telegram button pressed
                                            _launchUrl(
                                                "https://t.me/aastuecsf");
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.telegram,
                                                color: Colors.white,
                                                size: 30.0,
                                              ),
                                              SizedBox(width: 1),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors
                                                .transparent, // Set the text color to white
                                            elevation:
                                                0, // Remove the button's elevation
                                            padding: EdgeInsets
                                                .zero, // Remove the button's padding
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap, // Reduce the button's tap target size
                                            side: BorderSide
                                                .none, // Remove the button's border
                                          ),
                                          onPressed: () {
                                            // Handle Instagram button pressed
                                            _launchUrl(
                                                "https://instagram.com/aastuecsf?igshid=MmU2YjMzNjRlOQ==");
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.instagram,
                                                color: Colors.white,
                                                size: 30.0,
                                              ),
                                              SizedBox(width: 3),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                  // display app version and build number

                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Version: 1.0.4  build no. 4  ",
                                style: MyText.subhead(context)!.copyWith(
                                  fontSize: 13,
                                  fontFamily: 'MyFont',
                                  color:
                                      const Color.fromARGB(179, 185, 185, 185),
                                ),
                              ),
                              const Icon(
                                Icons.copyright,
                                size: 13,
                                color: Color.fromARGB(179, 185, 185, 185),
                              ),
                              Text(
                                " ${DateTime.now().year}",
                                style: MyText.subhead(context)!.copyWith(
                                  fontSize: 13,
                                  fontFamily: 'MyFont',
                                  color:
                                      const Color.fromARGB(179, 185, 185, 185),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 5),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10),
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
    final Uri url = Uri.parse(s);
    final ChromeSafariBrowser browser = ChromeSafariBrowser();
    await browser.open(
      url: url,
      options: ChromeSafariBrowserClassOptions(
        android: AndroidChromeCustomTabsOptions(),
        ios: IOSSafariOptions(),
      ),
    );
  }

  Widget gemechisDialog(String name, String image, String title, String exp,
      String linkedin, String facebook, String instagram) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
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
                      radius: 50,
                      backgroundImage: AssetImage(Img.get(image)),
                    ),
                    Container(height: 10),
                    Text(name,
                        textAlign: TextAlign.left,
                        style: MyText.headline(context)!.copyWith(
                            fontFamily: 'MyFont',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Container(height: 2),
                    Text(title,
                        textAlign: TextAlign.start,
                        style: MyText.body1(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_40)),
                    Container(height: 35),
                    Text(exp,
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_40)),
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
                        style: MyText.body1(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_20)),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl(linkedin);
                          },
                          child: const Icon(FontAwesomeIcons.linkedin,
                              color: Colors.white, size: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(facebook);
                          },
                          child: const Icon(FontAwesomeIcons.facebook,
                              color: Colors.white, size: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(instagram);
                          },
                          child: const Icon(FontAwesomeIcons.instagram,
                              color: Colors.white, size: 25),
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

  Widget getabalewDialog(String name, String image, String title, String exp,
      String twitter, String tiktok, String instagram) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
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
                      radius: 50,
                      backgroundImage: AssetImage(Img.get(image)),
                    ),
                    Container(height: 10),
                    Text(name,
                        textAlign: TextAlign.left,
                        style: MyText.headline(context)!.copyWith(
                            fontFamily: 'MyFont',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Container(height: 2),
                    Text(title,
                        textAlign: TextAlign.start,
                        style: MyText.body1(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_40)),
                    Container(height: 35),
                    Text(exp,
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_40)),
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
                        style: MyText.body1(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_20)),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl(twitter);
                          },
                          child: const Icon(FontAwesomeIcons.twitter,
                              color: Colors.white, size: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(instagram);
                          },
                          child: const Icon(FontAwesomeIcons.instagram,
                              color: Colors.white, size: 25),
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

  Widget dagimDialog(String name, String image, String title, String exp,
      String telegram, String tiktok, String instagram) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
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
                      radius: 50,
                      backgroundImage: AssetImage(Img.get(image)),
                    ),
                    Container(height: 10),
                    Text(name,
                        textAlign: TextAlign.left,
                        style: MyText.headline(context)!.copyWith(
                            fontFamily: 'MyFont',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Container(height: 2),
                    Text(title,
                        textAlign: TextAlign.start,
                        style: MyText.body1(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_40)),
                    Container(height: 35),
                    Text(exp,
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_40)),
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
                        style: MyText.body1(context)!.copyWith(
                            fontFamily: 'MyFont', color: MyColors.grey_20)),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl(telegram);
                          },
                          child: const Icon(FontAwesomeIcons.telegram,
                              color: Colors.white, size: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(tiktok);
                          },
                          child: const Icon(FontAwesomeIcons.tiktok,
                              color: Colors.white, size: 25),
                        ),
                        Container(width: 25),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(instagram);
                          },
                          child: const Icon(FontAwesomeIcons.instagram,
                              color: Colors.white, size: 25),
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
