import 'package:flutter/material.dart';
import 'package:aastu_ecsf/other_pages/events_list.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/news.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

class EventsRoute extends StatefulWidget {
  EventsRoute();

  @override
  EventsRouteState createState() => new EventsRouteState();
}

class EventsRouteState extends State<EventsRoute> {
  late BuildContext context;
  void onItemClick(int index, News obj) {
    MyToast.show("Event " + index.toString() + "clicked", context,
        duration: MyToast.LENGTH_SHORT);
  }

  List<String> all_images = [
    "fello_6.jpg",
    "concert2014_6.jpg",
    "fello_2.jpg",
    "concert2014_5.jpg"
  ];
  List<String> title = [
    "Worship Team",
    "GC Batch Program",
    "Fresh Batch Program",
    "Retreat"
  ];
  List<String> category = ["General", "Batch", "Batch", "Team"];
  List<String> full_date = [
    "Wed, 12:00 LT",
    "Tuesday 12:00 LT",
    "Monday, 12:00 LT",
    "Friday - Sunday"
  ];
  @override
  Widget build(BuildContext context) {
    this.context = context;
    List<News> items = [];
    for (int i = 0; i < 4; i++) {
      News obj = new News();
      obj.image = all_images[i];
      obj.title = title[i];
      obj.subtitle = category[i];
      obj.date = full_date[i];
      items.add(obj);
    }
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              //   brightness: Brightness.dark,
              backgroundColor: const Color(0xff121212),
              centerTitle: false,
              pinned: true,
              title: const Text("Fellowship Events",
                  style: TextStyle(color: MyColors.grey_10, fontSize: 18)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: MyColors.grey_10),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: const <Widget>[
                // overflow menu
              ]),
          ListNewsImageAdapter(items, onItemClick).getView()
        ],
      ),
    );
  }
}
