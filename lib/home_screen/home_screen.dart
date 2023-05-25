import 'dart:developer';
import 'dart:ui';
import 'package:aastu_ecsf/other_pages/events.dart';
import 'package:aastu_ecsf/other_pages/profile.dart';
import 'package:aastu_ecsf/home_screen/youtube_slider.dart';
import 'package:aastu_ecsf/feed_screen/blog_detail.dart';
import 'package:aastu_ecsf/other_pages/gift.dart';
import 'package:aastu_ecsf/other_pages/team.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('blogs');
  List<Map<dynamic, dynamic>> devotions = [];

  @override
  void initState() {
    super.initState();
    loadDevotions();
  }

  void loadDevotions() {
    log("Loading Devotions...");
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

            log("Devotions loaded!");

            // print id
            log("ID: " + devotions[0]['id']);
          });
        } else {
          // Handle the case when `snapshot.value` is not a Map<dynamic, dynamic>
          log("Can't Iterate Snapshot");
        }
      } else {
        // Handle the case when `snapshot.value` is null
        log("Can't load data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
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
                    color: const Color(0xff121212),
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
                            child: const Text(
                              "Features",
                              style: TextStyle(
                                  fontFamily: 'MyBoldFont',
                                  color: Colors.white,
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
                                  const Text(
                                    'Teams',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: Color(0xff808080),
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
                                    color: Colors.white,
                                    onPressed: () {
                                      log("Gift Clicked");

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GiftRoute()),
                                      );
                                    },
                                  ),
                                  const Text(
                                    'Gifts',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: Color(0xff808080),
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
                                      // do something
                                    },
                                  ),
                                  const Text(
                                    'Programs',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: Color(0xff808080),
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
                                  const Text(
                                    'Events',
                                    style: TextStyle(
                                      fontFamily: 'MyLightFont',
                                      color: Color(0xff808080),
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
                                const Expanded(
                                  child: Text(
                                    "Recent Devotions",
                                    style: TextStyle(
                                        fontFamily: 'MyBoldFont',
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Color(0xff808080),
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
      color: const Color(0xff1f1f1f),
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
    required String views,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          // passing id to DevoationDetail
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => DevoationDetail(idd: id),
            ),
          );
        },
        child: Card(
          color: const Color(0xff212121),
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'MyFont',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(height: 3),
                    Text(
                      date,
                      style: const TextStyle(
                        fontFamily: 'MyLightFont',
                        color: Color(0xff808080),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(height: 10),
                    Text(
                      views,
                      style: const TextStyle(
                        color: Color(0xff808080),
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.star,
                              size: 11,
                              color: Color(0xffD1A552),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: Color(0xffD1A552),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: Color.fromARGB(255, 202, 141, 84),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: Color(0xffCA7754),
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: Color(0xffCA7754),
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
                              child: const Positioned(
                                left: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(
                                      "assets/images/photo_female_4.jpg"),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(0, 0),
                              child: const Positioned(
                                left: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(
                                      "assets/images/photo_male_7.jpg"),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(8, 0),
                              child: const Positioned(
                                left: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(
                                      "assets/images/photo_female_8.jpg"),
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

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/logo.png',
                    // adjust this value as needed
                    width: 120,
                    height: 60 // adjust this value as needed
                    ),
              ],
            ),
          ),
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
