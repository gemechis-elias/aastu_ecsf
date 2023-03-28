import 'package:aastu_ecsf/home_screen/bible_progress_card.dart';
import 'package:aastu_ecsf/home_screen/course_info_screen.dart';
import 'package:aastu_ecsf/home_screen/features_card_view.dart';
import 'package:aastu_ecsf/main.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'latest_blogs_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryType categoryType = CategoryType.ui;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HomeScreenAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getProgerssUI(),
                      // getSearchBarUI(),
                      getBlogUI(),
                      Flexible(
                        child: getFeatures(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBlogUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Latest Blogs',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: HomeScreenAppTheme.darkerText,
            ),
          ),
        ),
        BlogListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getProgerssUI() {
    final hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 18) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 18, right: 16),
          child: Text(
            '$greeting, Gemechis',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 0.27,
              color: HomeScreenAppTheme.darkerText,
            ),
          ),
        ),
        CategoryListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getFeatures() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Features',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: HomeScreenAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: PopularCourseListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? HomeScreenAppTheme.nearlyBlue
                : HomeScreenAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: HomeScreenAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? HomeScreenAppTheme.nearlyWhite
                        : HomeScreenAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget getSearchBarUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0, left: 18),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.75,
  //           height: 64,
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 8, bottom: 8),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: HexColor('#F8FAFB'),
  //                 borderRadius: const BorderRadius.only(
  //                   bottomRight: Radius.circular(13.0),
  //                   bottomLeft: Radius.circular(13.0),
  //                   topLeft: Radius.circular(13.0),
  //                   topRight: Radius.circular(13.0),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: <Widget>[
  //                   Expanded(
  //                     child: Container(
  //                       padding: const EdgeInsets.only(left: 16, right: 16),
  //                       child: TextFormField(
  //                         style: TextStyle(
  //                           fontFamily: 'WorkSans',
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16,
  //                           color: HomeScreenAppTheme.nearlyBlue,
  //                         ),
  //                         keyboardType: TextInputType.text,
  //                         decoration: InputDecoration(
  //                           labelText: 'Search ...',
  //                           border: InputBorder.none,
  //                           helperStyle: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16,
  //                             color: HexColor('#B9BABC'),
  //                           ),
  //                           labelStyle: TextStyle(
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 16,
  //                             letterSpacing: 0.2,
  //                             color: HexColor('#B9BABC'),
  //                           ),
  //                         ),
  //                         onEditingComplete: () {},
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 60,
  //                     height: 60,
  //                     child: Icon(Icons.search, color: HexColor('#B9BABC')),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         const Expanded(
  //           child: SizedBox(),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: HomeScreenAppTheme.grey,
                  ),
                ),
                Text(
                  'AASTU ECSF',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: HomeScreenAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/design_course/userImage.png'),
          )
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
