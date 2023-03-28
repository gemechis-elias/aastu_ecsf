import 'dart:math';

import 'package:flutter/material.dart';
import 'package:aastu_ecsf/adapter/list_news_light_adapter.dart';
import 'package:aastu_ecsf/data/dummy.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/news.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

class ListNewsLightRoute extends StatefulWidget {
  ListNewsLightRoute();

  @override
  ListNewsLightRouteState createState() => new ListNewsLightRouteState();
}

class ListNewsLightRouteState extends State<ListNewsLightRoute> {
  late BuildContext context;

  void onItemClick(int index, News obj) {
    MyToast.show("News " + index.toString() + "clicked", context,
        duration: MyToast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    const List<String> all_images = [
      "blog_1.jpg",
      "blog_2.jpg",
      "blog_3.jpg",
      "blog_4.jpg",
    ];
    const List<String> strings_medium = [
      "ኢየሱስ? ወይስ ሞት? - ሰው እውነትን የሚያውቀው እግዚአብሔርን በክርስቶስ ባወቀ ጊዜ ብቻ ነው።",
      "ፍጹም ደስታ፣ ከሁኔታ በላይ የሆነ ሰላምና እውነተኛ መከናወን ያለው በእርሱ ፈቃድ ውስጥ ለተገኘ ሰው ነው። ",
      "መስቀሉ፦ ሲሞን ቬይ",
      "በዚያ ያለውን እንድታደራጅ ተውሁህ!"
    ];
    const List<String> news_category = ["Zeritu", "Biniyam", "Meri", "Abel"];
    const List<String> full_date = [
      "Dec 15, 2022",
      "Dec 15, 2022",
      "Dec 15, 2022",
      "Dec 15, 2022",
    ];
    Random random = new Random();
    List<News> items = [];
    for (int i = 0; i < 4; i++) {
      News obj = new News();
      obj.image = all_images[i];
      obj.title = strings_medium[i];
      obj.subtitle = news_category[i];
      obj.date = full_date[i];
      items.add(obj);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text(
              "Daily Enjera",
              style: TextStyle(
                color: MyColors.grey_60,
                fontSize: 20,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.my_library_books, color: MyColors.grey_60),
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.post_add, color: MyColors.grey_60),
                onPressed: () {},
              ),
              // overflow menu
            ],
          ),
          ListNewsLightAdapter(items, onItemClick).getView(),
        ],
      ),
    );
  }
}
