import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/gallery/gallery_cards_include.dart';
import 'package:aastu_ecsf/gallery/gallery_detail.dart';
import 'package:aastu_ecsf/gallery/gallery_filtered.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

class GalleryRoute extends StatefulWidget {
  GalleryRoute({Key? key}) : super(key: key);

  @override
  _GalleryRouteState createState() => _GalleryRouteState();
}

class _GalleryRouteState extends State<GalleryRoute>
    with TickerProviderStateMixin {
  late BuildContext _scaffoldCtx;

  @override
  Widget build(BuildContext context) {
    List<RxBool> filterFlag = [
      false.obs,
      false.obs,
      true.obs,
    ];
    List<int> filterIndex = List.generate(filterFlag.length, (index) => index);

    List<String> filterLabel = [
      "I4U",
      "LAD",
      "Concerts",
    ];

    var selectedScreen = "2015".obs;
    List<String> YearData = [
      "2015",
      "2014",
      "2013",
    ];

    int sectCount = 0;
    int sectIdx = 0;

    void onItemClick(int index, People obj) {
      MyToast.show(obj.name!, context, duration: MyToast.LENGTH_SHORT);
    }

    return BackdropScaffold(
      backgroundColor: const Color(0xff1f1f1f),
      backLayerBackgroundColor: const Color(0xff212121),
      animationCurve: Curves.linear,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
        value: 1,
      ),
      appBar: BackdropAppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xffd1a552), Color.fromARGB(255, 209, 150, 82)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Gallery",
            style: TextStyle(
              fontFamily: 'MyBoldFont',
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xff121212),
        brightness: Brightness.dark,
        actions: const <Widget>[
          BackdropToggleButton(
              color: Colors.white, icon: AnimatedIcons.list_view)
        ],
      ),
      headerHeight: 155,
      frontLayerBorderRadius: const BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(0),
      ),
      backLayer: Builder(
        builder: (BuildContext context) {
          _scaffoldCtx = context;
          return Container(
            color: const Color(0xff212121),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 20, bottom: 15),
                    child: Text(
                      "Teams",
                      style: MyText.body2(context)!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: Column(
                      children: filterIndex
                          .map(
                            (r) => Row(
                              children: <Widget>[
                                Obx(
                                  () => Checkbox(
                                    checkColor: Colors.deepPurpleAccent[700],
                                    activeColor: Colors.white,
                                    value: filterFlag[r].value,
                                    onChanged: (value) {
                                      filterFlag[r].value = value!;
                                    },
                                  ),
                                ),
                                Container(width: 10),
                                Text(
                                  filterLabel[r],
                                  style: MyText.body1(context)!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Divider(
                      height: 0,
                      color: MyColors.grey_40,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 20, bottom: 15),
                    child: Text(
                      "Year",
                      style: MyText.body2(context)!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        children: YearData.map(
                          (r) => RadioListTile(
                            title: Text(
                              r,
                              style: MyText.body1(context)!
                                  .copyWith(color: Colors.white),
                            ),
                            dense: true,
                            activeColor: Colors.white,
                            tileColor: Colors.white,
                            contentPadding: const EdgeInsets.all(0),
                            groupValue: selectedScreen.value,
                            selected: r == selectedScreen.value,
                            value: r,
                            onChanged: (dynamic val) {
                              selectedScreen.value = val;
                            },
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        List<String> selectedFilters = [];
                        for (int i = 0; i < filterFlag.length; i++) {
                          if (filterFlag[i].value) {
                            selectedFilters.add(filterLabel[i]);
                          }
                        }
                        log("Selected Items: $selectedFilters${selectedScreen.value}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryFiltered(
                              tag: selectedFilters[0],
                              year: selectedScreen.value,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        '  Filter  ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(height: 15),
                ],
              ),
            ),
          );
        },
      ),
      frontLayerScrim: Colors.transparent,
      frontLayer: Container(color: const Color(0xff1f1f1f), child: Gallery()),
    );
  }

  Widget Gallery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(2),
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryDetailRoute(),
                ),
              );
            },
            child: Card(
              color: const Color(0xff212121),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    Img.get('general.jpg'),
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "General Fellowship Gallery",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Container(height: 10),
                        Container(
                          child: const Text(
                            "Explore images of our fellowship events of all batches",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff808080),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 8),
                      TextButton(
                        style:
                            TextButton.styleFrom(primary: Colors.transparent),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GalleryDetailRoute(),
                              ),
                            );
                          },
                          child: const Text(
                            "EXPLORE",
                            style: TextStyle(color: Color(0xffd1a522)),
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Container(height: 5)
                ],
              ),
            ),
          ),
          Container(height: 5),
          Card(
            color: const Color(0xff212121),
            child: GalleryCardsInclude.get(context),
          ),
        ],
      ),
    );
  }
}
