import 'package:aastu_ecsf/gallery/gallery_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aastu_ecsf/model/bottom_nav.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'dart:developer';
import 'package:aastu_ecsf/home_screen/home_screen.dart';
import 'package:aastu_ecsf/about_screen/about_us.dart';

import 'feed_screen/list_news_light.dart';

class BottomNavigationBadgeRoute extends StatefulWidget {
  final List<BottomNav> itemsNav = <BottomNav>[
    BottomNav('Home', Icons.home, null),
    BottomNav('Read', Icons.chrome_reader_mode, null),
    BottomNav('Gallery', Icons.image, null),
    BottomNav('Profile', Icons.person, null)
  ];

  @override
  BottomNavigationBadgeState createState() => BottomNavigationBadgeState();
}

class BottomNavigationBadgeState extends State<BottomNavigationBadgeRoute>
    with TickerProviderStateMixin<BottomNavigationBadgeRoute> {
  var currentIndex = 0.obs;
  final List<Widget> _pages = [
    HomeScreen(),
    ListNewsLightRoute(),
    SearchCityRoute(),
    AboutCompanyCardRoute(),
  ];

  late BuildContext ctx;

  void onBackPress() {
    if (Navigator.of(ctx).canPop()) {
      Navigator.of(ctx).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex.toInt(),
        children: _pages,
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            elevation: 15,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue[700],
            unselectedItemColor: Colors.grey[400],
            currentIndex: currentIndex.value,
            onTap: (int index) {
              setState(() {
                currentIndex.value = index;
                log('Index: $currentIndex ');
              });
            },
            items: widget.itemsNav.map((BottomNav d) {
              return BottomNavigationBarItem(
                icon: !d.badge
                    ? Icon(d.icon)
                    : Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Icon(d.icon),
                          Positioned(
                            right: -18,
                            top: -8,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              width: 25,
                              height: 15,
                              child: Wrap(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 10,
                                      minHeight: 10,
                                    ),
                                    child: d.badgeText == ""
                                        ? Container(width: 0, height: 0)
                                        : Text(d.badgeText,
                                            style: MyText.overline(context)!
                                                .copyWith(color: Colors.white)),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                label: d.title,
              );
            }).toList(),
          )),
    );
  }
}
