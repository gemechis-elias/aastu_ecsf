import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/app_theme.dart';
import 'package:aastu_ecsf/route/youtube_screen/youtube_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:skeletons/skeletons.dart';

class SliderImageHeaderAutoRoute extends StatefulWidget {
  const SliderImageHeaderAutoRoute({super.key});

  @override
  SliderImageHeaderAutoRouteState createState() =>
      SliderImageHeaderAutoRouteState();
}

class SliderImageHeaderAutoRouteState
    extends State<SliderImageHeaderAutoRoute> {
  static const int MAX = 3;

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('slider');
  List<Map<dynamic, dynamic>> slides = [];
  int page = 0;
  Timer? timer;
  late Map<dynamic, dynamic> videoObject;

  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
    log("slides", name: slides.toString());

    videoObject = {
      'addedDate': "00:00",
      'description': "Loading...",
      'link': "https://www.youtube.com/watch?v=R6EQHdDwME8",
      'thumbnail': "",
      'title': "Loading...",
    };

    timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      page = page + 1;
      if (page >= slides.length) page = 0;

      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 2000), curve: Curves.linear);
      log("animateToPage");
      setState(() {
        log("Slide length:${slides.length}Pages : $page");
        if (slides.isNotEmpty) {
          videoObject = slides[page];
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null && timer!.isActive) timer!.cancel();
  }

  void enableDatabasePersistence() {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000); // 10MB
  }

  void fetchDataFromFirebase() async {
    databaseReference.limitToLast(4).onValue.listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        dynamic value = snapshot.value;
        if (value is Map<dynamic, dynamic>) {
          value.forEach((key, value1) {
            Map<dynamic, dynamic> sld = {
              'id': key,
              'addedDate': value1['addedDate'],
              'link': value1['link'],
              'description': value1['description'],
              'thumbnail': value1['thumbnail'],
              'title': value1['title'],
            };
            slides.add(sld);
          });
          setState(() {
            this.slides = slides;
            log("sliders${slides[0]}");
          });
        } else {
          log("Can't Iterate Snapshot");
        }
      }
    });
  }

  String getYouTubeVideoId(String url) {
    // Check if the URL is not empty
    if (url.isNotEmpty) {
      // Extract the query parameters from the URL
      Uri uri = Uri.parse(url);
      String? videoId = uri.queryParameters['v'];

      // Check if the video ID is not empty
      if (videoId != null && videoId.isNotEmpty) {
        return videoId;
      }
    }

    // If the URL is invalid or no video ID found, return null or handle the error as needed
    return "R6EQHdDwME8";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => YoutubePlayerDemoApp(
                ids: getYouTubeVideoId(videoObject['link'])),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Material(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              elevation: 0,
              margin: const EdgeInsets.all(0),
              child: Container(
                color: AppTheme.bodyBackground(context),
                height: MediaQuery.of(context).size.height * 0.33,
                child: Stack(
                  children: <Widget>[
                    PageView(
                      controller: pageController,
                      onPageChanged: onPageViewChange,
                      children: getImagesHeader(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.gridentBackground(context)
                                  .withOpacity(0.0),
                              AppTheme.gridentBackground(context)
                                  .withOpacity(0.5),
                              AppTheme.gridentBackground(context)
                                  .withOpacity(0.95),
                              AppTheme.gridentBackground(context)
                                  .withOpacity(1.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          10, MediaQuery.of(context).size.height * 0.24, 0, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    videoObject['title'] ?? '',
                                    style: TextStyle(
                                      color: AppTheme.normalText(context),
                                      fontSize: 13,
                                      fontFamily: 'MyBoldFont',
                                    ),
                                  ),
                                  Text(
                                    videoObject['description'] ?? '',
                                    style: TextStyle(
                                      color: AppTheme.iconBackground(context),
                                      fontSize: 13,
                                      fontFamily: 'MyBoldFont',
                                    ),
                                  ),
                                  Text(
                                    videoObject['addedDate'] ?? '',
                                    style: TextStyle(
                                      color: AppTheme.iconBackground(context),
                                      fontSize: 12,
                                      fontFamily: 'MyFont',
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Ink(
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: const CircleBorder(),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  log("Playe clicked");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          YoutubePlayerDemoApp(
                                        ids: getYouTubeVideoId(
                                            videoObject['link']),
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 6, 0),
                                  child: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: [
                                          AppTheme.activeIconBackground(
                                              context),
                                          AppTheme.activeIcon2Background(
                                              context),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds);
                                    },
                                    child: const Icon(
                                      Icons.play_circle_filled_outlined,
                                      size: 53,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.4,
                            MediaQuery.of(context).size.height * 0.26,
                            0,
                            0),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildDots(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageViewChange(int page) {
    page = page;
    setState(() {});
  }

  List<Widget> getImagesHeader() {
    List<Widget> lw = [];
    for (Map<dynamic, dynamic> slide in slides) {
      lw.add(CachedNetworkImage(
        imageUrl: slide['thumbnail'],
        placeholder: (context, url) => SkeletonItem(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF222222),
                  Color(0xFF242424),
                  Color(0xFF2B2B2B),
                  Color(0xFF242424),
                  Color(0xFF222222),
                ],
              ),
            ),
          ),
        ),
        fit: BoxFit.cover,
      ));
    }
    return lw;
  }

  Widget buildDots(BuildContext context) {
    Widget widget;

    List<Widget> dots = [];
    for (int i = 0; i < MAX; i++) {
      Widget w = Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 7,
        width: page == i ? 20 : 9,
        decoration: BoxDecoration(
          color: page == i
              ? AppTheme.activeIconBackground(context)
              : Colors.transparent,
          borderRadius:
              page == i ? BorderRadius.circular(6) : BorderRadius.circular(7),
          border: page == i
              ? Border.all(color: AppTheme.iconBackground(context), width: 0.5)
              : Border.all(color: AppTheme.iconBackground(context), width: 1.0),
        ),
      );
      dots.add(w);
    }
    widget = Row(
      children: dots,
    );
    return widget;
  }
}
