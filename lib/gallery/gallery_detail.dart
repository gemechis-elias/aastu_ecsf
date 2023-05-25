import 'package:flutter/material.dart';
import 'package:aastu_ecsf/gallery/grid_sectioned_adapter.dart';
import 'package:aastu_ecsf/data/dummy.dart';
import 'package:aastu_ecsf/model/section_image.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:aastu_ecsf/widget/toolbar.dart';

class GridSectionedRoute extends StatefulWidget {
  GridSectionedRoute();

  @override
  GridSectionedRouteState createState() => new GridSectionedRouteState();
}

class GridSectionedRouteState extends State<GridSectionedRoute> {
  void onItemClick(int index, String obj) {
    MyToast.show(obj, context, duration: MyToast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    List<String> itemsImg = Dummy.getNatureImages();
    itemsImg.addAll(Dummy.getNatureImages());
    itemsImg.addAll(Dummy.getNatureImages());
    itemsImg.addAll(Dummy.getNatureImages());
    itemsImg.addAll(Dummy.getNatureImages());

    List<SectionImage> items = [];
    for (String i in itemsImg) {
      items.add(SectionImage(i, "IMG_" + i + ".jpg", false));
    }

    int sectCount = 0;
    int sectIdx = 0;
    List<String> months = Dummy.getStringsMonth();
    for (int i = 0; i < items.length / 10; i++) {
      items.insert(sectCount, SectionImage("", months[sectIdx], true));
      sectCount = sectCount + 10;
      sectIdx++;
    }

    return Scaffold(
      backgroundColor: Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Fellowship Gallary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GridSectionedAdapter(items, onItemClick).getView(),
    );
  }
}
