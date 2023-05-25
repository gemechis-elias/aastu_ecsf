import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/home_screen/youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/model/model_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class SliderImageHeaderAutoRoute extends StatefulWidget {
  SliderImageHeaderAutoRoute();

  @override
  SliderImageHeaderAutoRouteState createState() =>
      SliderImageHeaderAutoRouteState();
}

class SliderImageHeaderAutoRouteState
    extends State<SliderImageHeaderAutoRoute> {
  static const int MAX = 3;

  final List<ModelImage> items = getModelImage();
  int page = 0;
  Timer? timer;
  late ModelImage curObj;

  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    curObj = items[0];
    timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      page = page + 1;
      if (page >= MAX) page = 0;
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 2000), curve: Curves.linear);
      log("animateToPage");
      setState(() {
        curObj = items[page];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null && timer!.isActive) timer!.cancel();
  }

  static List<ModelImage> getModelImage() {
    List<String> all_images = [
      "concert2014_1.jpg",
      "slide1.jpg",
      "fello_1.jpg",
    ];
    List<String> title = [
      "Nefse Tetemach Concert",
      "Tekeblonal Worship Song",
      "Worship Time at AASTU",
    ];
    List<String> name = [
      "Adonias Abebe",
      "Choir Team",
      "Hana Yoseph",
    ];

    List<String> date = [
      "6:00 min",
      "8:00 min",
      "3:00 min",
    ];

    final List<ModelImage> items = [];
    for (int i = 0; i < 3; i++) {
      ModelImage obj = new ModelImage();
      obj.image = all_images[i];
      obj.title = title[i];
      obj.name = name[i];
      obj.date = date[i];
      items.add(obj);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                const YoutubePlayerDemoApp(ids: "R6EQHdDwME8"),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Material(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              elevation: 0,
              margin: const EdgeInsets.all(0),
              child: Container(
                color: const Color(0xff1F1F1F),
                height: 195,
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
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              const Color(0xff1F1F1F).withOpacity(0.0),
                              const Color(0xff1F1F1F).withOpacity(0.3),
                              const Color(0xff1F1F1F).withOpacity(0.5),
                              const Color(0xff1F1F1F).withOpacity(1.0)
                            ])),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform.translate(
                        offset: const Offset(0, 67),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment
                                .end, // Align the column to the bottom
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(curObj.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'MyBoldFont',
                                  )),
                              Text(curObj.name,
                                  style: const TextStyle(
                                    color: Color(0xff808080),
                                    fontSize: 13,
                                    fontFamily: 'MyBoldFont',
                                  )),
                              Transform.translate(
                                offset: const Offset(0, -20),
                                child: Row(
                                  children: <Widget>[
                                    Container(width: 1),
                                    Text(
                                      curObj.date,
                                      style: const TextStyle(
                                        color: Color(0xff808080),
                                        fontSize: 12,
                                        fontFamily: 'MyFont',
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: <Widget>[
                                        buildDots(context),
                                        Container(
                                            alignment: Alignment.center,
                                            width: 80),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const YoutubePlayerDemoApp(
                                                          ids: "R6EQHdDwME8")),
                                            );
                                          },
                                          child: MaterialButton(
                                            minWidth: 0,
                                            height: 53,
                                            shape: const CircleBorder(),
                                            onPressed: () {},
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return const LinearGradient(
                                                  colors: [
                                                    Color(0xffD1A552),
                                                    Color(0xffCA7754),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds);
                                              },
                                              child: const Icon(
                                                Icons
                                                    .play_circle_filled_outlined,
                                                size: 53,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    setState(() {});
  }

  List<Widget> getImagesHeader() {
    List<Widget> lw = [];
    for (ModelImage mi in items) {
      lw.add(Image.asset(Img.get(mi.image), fit: BoxFit.cover));
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
            color: page == i ? const Color(0xffD1A552) : Colors.transparent,
            borderRadius:
                page == i ? BorderRadius.circular(6) : BorderRadius.circular(7),
            border: page == i
                ? Border.all(color: const Color(0xff808080), width: 0.5)
                : Border.all(color: const Color(0xff808080), width: 1.0)),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }
}
