// ignore_for_file: library_private_types_in_public_api
import 'dart:developer' as developer;
import 'dart:math';
import 'package:aastu_ecsf/app_theme.dart';
import 'package:aastu_ecsf/route/blog_screen/single_devotion_view.dart';
import 'package:aastu_ecsf/route/features/events.dart';
import 'package:aastu_ecsf/route/user/profile.dart';
import 'package:aastu_ecsf/route/youtube_screen/youtube_slider.dart';
import 'package:aastu_ecsf/route/features/support_fellowship.dart';
import 'package:aastu_ecsf/route/features/team.dart';
import 'package:aastu_ecsf/route/features/wallpapers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('blogs'); // devotions blogs
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
            developer.log("Devotions loaded successfully! ");
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

// function get random images for the small circle avatars
  String getRandomImage() {
    List<String> images = [
      "assets/people/user1.jpg",
      "assets/people/user2.jpg",
      "assets/people/user3.jpg",
      "assets/people/user4.jpg",
      "assets/people/user5.jpg",
      "assets/people/user6.jpg",
      "assets/people/user7.jpg",
      "assets/people/user8.jpg",
      "assets/people/user7.jpg",
      "assets/people/user6.jpg",
      "assets/people/user5.jpg",
      "assets/people/user4.jpg",
      "assets/people/user3.jpg",
      "assets/people/user2.jpg",
    ];
    final random = Random();
    final index = random.nextInt(images.length);
    return images[index];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveHeight = screenHeight * 0.267;

    String id, title, imagePath, date, devoLink, views;
    return Scaffold(
      backgroundColor: AppTheme.bodyBackground(context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
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

                const SliderImageHeaderAutoRoute(),
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
                        fontSize: MediaQuery.of(context).size.width * 0.047,
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
                          icon: Image.asset(
                            'assets/images/team.png',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          onPressed: () {
                            developer.log("Team Clicked");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TeamCardRoute()),
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
                          icon: Image.asset(
                            'assets/images/gift.png',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          color: AppTheme.normalText(context),
                          onPressed: () {
                            developer.log("Gift Clicked");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SupportFellowshipRoute()),
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
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
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
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          onPressed: () {
                            // do something
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EventsRoute()),
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.047,
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: responsiveHeight,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: devotions.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            height: 2,
                            thickness: 1,
                            color: Color.fromARGB(188, 189, 189, 189),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            Map<dynamic, dynamic> devotion = devotions[index];
                            id = devotions[index]['id'];
                            title = devotion['title'];
                            imagePath = devotion['image'];
                            date = devotion['addedDate'];
                            devoLink = devotion['content'];
                            views = "1k+ Views"; // defualt value

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  // passing id and link to Devotion Detail Page
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            DevotionDetail(
                                                idd: id, link: devoLink)),
                                  );
                                  //openDevotions(devoLink);
                                  // WebViewPage(url: devoLink);
                                },
                                child: Card(
                                  elevation: 2,
                                  color: const Color(0xff212121),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: imagePath,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: SizedBox(
                                              width:
                                                  24, // Adjust the size as needed
                                              height:
                                                  24, // Adjust the size as needed
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.26,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 130,
                                              child: Text(
                                                title,
                                                style: TextStyle(
                                                  fontFamily: 'MyFont',
                                                  color: AppTheme.normalText(
                                                      context),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.036,
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
                                                color: AppTheme.iconBackground(
                                                    context),
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Container(height: 5),
                                            Text(
                                              views,
                                              style: TextStyle(
                                                fontFamily: 'MyLightFont',
                                                color: AppTheme.iconBackground(
                                                    context),
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
                                                      color: AppTheme
                                                          .activeIconBackground(
                                                              context),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 11,
                                                      color: AppTheme
                                                          .activeIconBackground(
                                                              context),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 11,
                                                      color: AppTheme
                                                          .activeIconBackground(
                                                              context),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 11,
                                                      color: AppTheme
                                                          .activeIcon2Background(
                                                              context),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 11,
                                                      color: AppTheme
                                                          .activeIcon2Background(
                                                              context),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 20,
                                                ),
                                                for (int i = 0; i < 3; i++)
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 0),
                                                    child: Align(
                                                        widthFactor: 0.65,
                                                        child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:
                                                              const Color(
                                                                  0xff212121),
                                                          child: CircleAvatar(
                                                            radius: 9,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    getRandomImage()),
                                                          ),
                                                        )),
                                                  )
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
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
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
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.076,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const UserProfileRoute(),
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

  Future<void> openDevotions(String s) async {
    developer.log("Link Clicked ");
    final Uri url = Uri.parse(s);
    final ChromeSafariBrowser browser = ChromeSafariBrowser();
    await browser.open(
      url: url,
      options: ChromeSafariBrowserClassOptions(
        android: AndroidChromeCustomTabsOptions(
          enableUrlBarHiding: true,
          toolbarBackgroundColor: Colors.black,
        ),
        ios: IOSSafariOptions(
          barCollapsingEnabled: true,
          preferredBarTintColor: Colors.black,
          preferredControlTintColor: Colors.white,
          dismissButtonStyle: IOSSafariDismissButtonStyle.CLOSE,
        ),
      ),
    );
  }
}
