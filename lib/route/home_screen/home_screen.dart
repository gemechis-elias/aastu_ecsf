import 'dart:developer' as developer;
import 'dart:math';
import 'package:aastu_ecsf/app_theme.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/route/feed_screen/devotion_detail.dart';
import 'package:aastu_ecsf/route/other_pages/events.dart';
import 'package:aastu_ecsf/route/other_pages/profile.dart';
import 'package:aastu_ecsf/route/home_screen/youtube_slider.dart';
import 'package:aastu_ecsf/route/other_pages/gift.dart';
import 'package:aastu_ecsf/route/other_pages/team.dart';
import 'package:aastu_ecsf/route/other_pages/wallpapers.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('blogs');
  List<Map<dynamic, dynamic>> devotions = [];

  @override
  void initState() {
    super.initState();
    loadDevotions();
  }

  void loadDevotions() {
    developer.log("Loading Devotions...");
    databaseReference
        .orderByChild('addedDate')
        .limitToLast(4)
        .onValue
        .listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        dynamic value = snapshot.value;
        if (value is Map<dynamic, dynamic>) {
          List<Map<dynamic, dynamic>> devotions = [];
          value.forEach((key, devotionData) {
            Map<dynamic, dynamic> devotion = {
              'id': key,
              'addedDate': devotionData['addedDate'],
              'author': devotionData['author'],
              'content': devotionData['content'],
              'image': devotionData['image'],
              'title': devotionData['title'],
            };
            devotions.add(devotion);
          });
          setState(() {
            this.devotions = devotions;

            developer.log("Devotions loaded!");

            // print id
            developer.log("ID: " + devotions[0]['id']);
          });
        } else {
          // Handle the case when `snapshot.value` is not a Map<dynamic, dynamic>
          developer.log("Can't Iterate Snapshot");
        }
      } else {
        // Handle the case when `snapshot.value` is null
        developer.log("Can't load data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBackground(context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Container(
                    color: AppTheme.navBackground(context),
                    child: getAppBarUI(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          getVideoSLider(),
                          Container(height: 50),
                          const Divider(
                            height: 2,
                            thickness: 1,
                            color: Color.fromARGB(188, 189, 189, 189),
                          ),
                          Container(height: 8),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Text(
                              "Features",
                              style: TextStyle(
                                  fontFamily: 'MyBoldFont',
                                  color: AppTheme.normalText(context),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(height: 10),
                          // ICONS LIST STARTS HERE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    iconSize: 58,
                                    icon: Image.asset('assets/images/team.png',
                                        width: 78),
                                    onPressed: () {
                                      print("Team Clicked");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TeamCardRoute()),
                                      );
                                    },
                                  ),
                                  Text(
                                    'Teams',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: AppTheme.normalText(context),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    iconSize: 58,
                                    icon: Image.asset('assets/images/gift.png',
                                        width: 78),
                                    color: AppTheme.normalText(context),
                                    onPressed: () {
                                      developer.log("Gift Clicked");

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GiftRoute()),
                                      );
                                    },
                                  ),
                                  Text(
                                    'Gifts',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: AppTheme.normalText(context),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    iconSize: 58,
                                    icon: Image.asset(
                                        'assets/images/programs.png',
                                        width: 78),
                                    onPressed: () {
                                      // show dialog program ShowProgram()
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       return ShowProgram();
                                      //     });
                                      developer.log("Wallpaper Clicked");

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WallpaperBasicRoute()),
                                      );
                                    },
                                  ),
                                  Text(
                                    'Wallpapers',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: AppTheme.normalText(context),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    iconSize: 58,
                                    icon: Image.asset(
                                        'assets/images/events.png',
                                        width: 78),
                                    onPressed: () {
                                      // do something
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EventsRoute()),
                                      );
                                    },
                                  ),
                                  Text(
                                    'Events',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: AppTheme.normalText(context),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Devotions List
                          Container(height: 13),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Recent Devotions",
                                    style: TextStyle(
                                        fontFamily: 'MyBoldFont',
                                        color: AppTheme.normalText(context),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: AppTheme.iconBackground(context),
                                ),
                                Container(
                                  width: 15,
                                )
                              ],
                            ),
                          ),

                          Container(
                            height: 10,
                          ),

                          DevotionsList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getVideoSLider() {
    return SliderImageHeaderAutoRoute();
  }

  // ignore: non_constant_identifier_names
  Widget DevotionsList() {
    return Container(
      color: AppTheme.bodyBackground(context),
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: devotions.length,
        itemBuilder: (BuildContext context, int index) {
          Map<dynamic, dynamic> devotion = devotions[index];

          return DevotionsUI(
            id: devotions[index]['id'],
            title: devotion['title'],
            imagePath: devotion['image'],
            date: devotion['addedDate'],
            link: devotion['content'],
            views: "1k+ Views",
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget DevotionsUI({
    required String id,
    required String title,
    required String imagePath,
    required String date,
    required String link,
    required String views,
  }) {
    List<String> images = [
      "assets/images/user1.jpg",
      "assets/images/user2.jpg",
      "assets/images/user3.jpg",
      "assets/images/user4.jpg",
    ];

    // Generate a random index for the images list
    final Random random = Random();
    int rnd1, rnd2, rnd3;

    do {
      rnd1 = random.nextInt(images.length);
      rnd2 = random.nextInt(images.length);
      rnd3 = random.nextInt(images.length);
    } while (rnd1 == rnd2 || rnd1 == rnd3 || rnd2 == rnd3);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          // passing id to DevoationDetail
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => DevoationDetail(
                  idd: id, link: link ?? "https://telegra.ph/Error-07-03-2"),
            ),
          );
        },
        child: Card(
          color: AppTheme.body2Background(context),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 24, // Adjust the size as needed
                      height: 24, // Adjust the size as needed
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: 150,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 130,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'MyFont',
                          color: AppTheme.normalText(context),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(height: 3),
                    Text(
                      date,
                      style: TextStyle(
                        fontFamily: 'MyLightFont',
                        color: AppTheme.iconBackground(context),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(height: 10),
                    Text(
                      views,
                      style: TextStyle(
                        color: AppTheme.iconBackground(context),
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 11,
                              color: AppTheme.activeIconBackground(context),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: AppTheme.activeIconBackground(context),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: AppTheme.activeIconBackground(context),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: AppTheme.activeIcon2Background(context),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: AppTheme.activeIcon2Background(context),
                            ),
                          ],
                        ),
                        Container(
                          width: 20,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Transform.translate(
                              offset: const Offset(-8, 0),
                              child: Positioned(
                                left: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(images[rnd1]),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(0, 0),
                              child: Positioned(
                                left: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(images[rnd2]),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(8, 0),
                              child: Positioned(
                                left: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(images[rnd3]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveTo() {
    // Navigator.push<dynamic>(
    //   context,
    //   MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => CourseInfoScreen(),
    //   ),
    // );
  }
  Widget ShowProgram() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: AppTheme.liveBackground(context),
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Icon(Icons.cloud_off, color: Colors.white, size: 80),
                    Container(height: 10),
                    Text("No Live Program!",
                        style: MyText.title(context)!
                            .copyWith(color: Colors.white)),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(
                        "You will receive notification when life program available.",
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!
                            .copyWith(color: MyColors.grey_60)),
                    Container(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.liveBackground(context),
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)),
                      ),
                      child:
                          Text("Close", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // MyToast.show("Loading...", context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 60,
                ),
              ],
            ),
          ),
          // IconButton(
          //   icon: Icon(
          //     isDarkMode ? Icons.wb_sunny : Icons.brightness_2,
          //     color: AppTheme.normalText(context),
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       isDarkMode = !isDarkMode;
          //       // if (isDarkMode) {
          //       //   // Set the app theme to dark
          //       //   ThemeManager.of(context).setBrightness(Brightness.dark);
          //       // } else {
          //       //   // Set the app theme to light
          //       //   ThemeManager.of(context).setBrightness(Brightness.light);
          //       // }
          //     });
          //   },
          // ),
          GestureDetector(
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => ProfilePolygonRoute(),
                ),
              );
            },
            child: SizedBox(
              width: 37,
              height: 37,
              child: Image.asset('assets/images/user.png'),
            ),
          ),
        ],
      ),
    );
  }
}
