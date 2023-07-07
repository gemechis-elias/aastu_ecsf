import 'package:aastu_ecsf/route/features/events_list.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/event.dart';

class EventsRoute extends StatefulWidget {
  const EventsRoute({super.key});

  @override
  EventsRouteState createState() => EventsRouteState();
}

class EventsRouteState extends State<EventsRoute> {
  @override
  late BuildContext context;
  void onItemClick(int index, Event obj) {
    // MyToast.show("Event " + index.toString() + "clicked", context,
    //     duration: MyToast.LENGTH_SHORT);
  }

  List<String> images = [
    "weekly.jpg",
    "retreat.jpg",
    "fresh.jpg",
    "pray.jpg",
    "retreatteam.jpg",
    "halflife.jpg"
  ];
  List<String> title = [
    "Weekly Worship ",
    "Fresh Batch Program",
    "GC Batch Program",
    "Morning Prayer",
    "Team Retreats",
    "Half Life Retreat",
  ];
  List<String> category = [
    "General",
    "Batch",
    "Batch",
    "FGeneral",
    "Team",
    "Batcn"
  ];
  List<String> date = [
    "Wed, 12:00 LT",
    "Monday, 12:00 LT",
    "Tuesday 12:00 LT",
    "Monday - Friday",
    "Friday - Sunday",
    "Friday - Sunday"
  ];
  @override
  Widget build(BuildContext context) {
    this.context = context;
    List<Event> items = [];
    for (int i = 0; i < 6; i++) {
      Event obj = Event();
      obj.image = images[i];
      obj.title = title[i];
      obj.category = category[i];
      obj.date = date[i];
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
                  style: TextStyle(
                      fontFamily: 'MyBoldFont',
                      color: MyColors.grey_10,
                      fontSize: 18)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: MyColors.grey_10),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: const <Widget>[
                // overflow menu
              ]),
          ListEventAdapter(items, onItemClick).getView()
        ],
      ),
    );
  }
}
