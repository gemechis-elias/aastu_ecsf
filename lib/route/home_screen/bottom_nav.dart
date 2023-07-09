import 'dart:developer';
import 'package:aastu_ecsf/app_theme.dart';
import 'package:aastu_ecsf/route/chat_screen/chat_home.dart';
import 'package:aastu_ecsf/route/gallery/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aastu_ecsf/route/home_screen/home_screen.dart';
import 'package:aastu_ecsf/route/about_screen/about_us.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blog_screen/blog_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBadgeRoute extends StatefulWidget {
  const BottomNavigationBadgeRoute({super.key});

  @override
  BottomNavigationBadgeState createState() => BottomNavigationBadgeState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class BottomNavigationBadgeState extends State<BottomNavigationBadgeRoute> {
  List<String> listOfIcons = [
    "assets/icons/tb_all.png",
    "assets/icons/msg_selectall.png",
    "assets/icons/member_media.png",
    "assets/icons/bm_chats.png",
    "assets/icons/contacts_all.png",
  ];

  List<IconData> listIcons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.newspaper,
    FontAwesomeIcons.images,
    FontAwesomeIcons.comments,
    FontAwesomeIcons.infoCircle,
  ];

  List<String> listOfStrings = [
    'Home',
    'Blogs',
    'Gallery',
    'Chat',
    'About',
  ];

  bool _hasStartedChat = false; // initialize to false

  @override
  void initState() {
    super.initState();
    _checkChatStatus();
    log("HomeScreen State Initiated");
  }

  void _checkChatStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasStartedChat = prefs.getBool('hasStartedChat') ?? false;
    setState(() {
      _hasStartedChat = hasStartedChat;
    });
  }

  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: AppTheme.body2Background(context),
        body: IndexedStack(
          index: currentIndex.toInt(),
          children: [
            const HomeScreen(),
            const ListNewsLightRoute(),
            GalleryRoute(),
            const ChatListRoute(),
            const AboutCompanyCardRoute(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(displayWidth * .01),
          height: displayWidth * .135,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: displayWidth * .01),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  currentIndex = index;
                  HapticFeedback.lightImpact();
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == currentIndex
                        ? displayWidth * .26
                        : displayWidth * .17,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == currentIndex ? displayWidth * .10 : 0,
                      width: index == currentIndex ? displayWidth * .28 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? AppTheme.activeIconBackground(context)
                                .withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == currentIndex
                        ? displayWidth * .28
                        : displayWidth * .12,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == currentIndex
                                  ? displayWidth * .11
                                  : 0,
                            ),
                            AnimatedOpacity(
                              opacity: index == currentIndex ? 1 : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                index == currentIndex
                                    ? '${listOfStrings[index]}'
                                    : '',
                                style: TextStyle(
                                  color: AppTheme.activeIconBackground(context),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "MyFont",
                                  fontSize: 11.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == currentIndex
                                  ? displayWidth * .03
                                  : 1,
                            ),
                            // Icon(
                            //   listIcons[index],
                            //   size: displayWidth * .060,
                            //   color: index == currentIndex
                            //       ? AppTheme.activeIconBackground(context)
                            //       : AppTheme.iconBackground(context),
                            // ),
                            ImageIcon(
                              AssetImage(listOfIcons[index]),
                              size: displayWidth * .060,
                              color: index == currentIndex
                                  ? AppTheme.activeIconBackground(context)
                                  : AppTheme.iconBackground(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
