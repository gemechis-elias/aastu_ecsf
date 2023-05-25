import 'dart:math';

import 'package:aastu_ecsf/data/TeamImage.dart';
import 'package:aastu_ecsf/other_pages/team_cards.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/model/music_album.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/widget/toolbar.dart';

class TeamCardRoute extends StatefulWidget {
  TeamCardRoute();

  @override
  MotionCardRouteState createState() => new MotionCardRouteState();
}

class MotionCardRouteState extends State<TeamCardRoute> {
  late BuildContext _scaffoldCtx;
  bool slow = true;
  static Random random = new Random();
  void onItemClick(int index, MusicAlbum obj) {
    Navigator.push(
        _scaffoldCtx,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: slow ? 500 : 1000),
            pageBuilder: (_, __, ___) => MotionCardDetails(index, obj)));
    slow = !slow;
  }

  @override
  Widget build(BuildContext context) {
    List<String> album_cover = [
      "i4u.jpg",
      "worship.jpg",
      "lad.jpg",
      "prayers.jpg"
    ];
    List<String> album_name = [
      "I4U Team",
      "Worship Team",
      "LAD Team",
      "Prayers Team",
    ];
    int getRandomIndex(int max) {
      return random.nextInt(max - 1);
    }

    List<MusicAlbum> getMusicAlbum1() {
      List<MusicAlbum> items = [];
      for (int i = 0; i < album_cover.length; i++) {
        MusicAlbum obj = new MusicAlbum();
        obj.image = album_cover[i];
        obj.name = album_name[i];
        obj.brief = "AASTU ECSF";
        obj.color = const Color(0xFFD1a552);
        items.add(obj);
      }
      items.shuffle();
      return items;
    }

    List<MusicAlbum> items = getMusicAlbum1();

    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: const Color(0xff1f1f1f),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Fellowship Teams'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        _scaffoldCtx = context;
        return GridMusicCardAlbum(items, onItemClick).getView();
      }),
    );
  }
}

class MotionCardDetails extends StatelessWidget {
  final int index;
  final MusicAlbum obj;

  MotionCardDetails(this.index, this.obj);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index.toString(),
      child: Scaffold(
        backgroundColor: const Color(0xff1f1f1f),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: const Color(0xff1f1f1f),
                expandedHeight: 400.0,
                brightness: Brightness.dark,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    children: [
                      Image.asset(TeamImage.get(obj.image),
                          fit: BoxFit.cover, height: 380),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 25),
                          alignment: Alignment.centerLeft,
                          height: 130,
                          color: const Color(0xffd1a522),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(obj.name,
                                      style: MyText.display1(context)!
                                          .copyWith(color: Colors.white)),
                                  Container(height: 5),
                                  Text(obj.brief,
                                      style: MyText.subhead(context)!
                                          .copyWith(color: Colors.white)),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                transform:
                                    Matrix4.translationValues(0.0, -25.0, 0.0),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ), // overflow menu
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              color: const Color(0xff212121),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(MyStrings.very_long_lorem_ipsum,
                      textAlign: TextAlign.justify,
                      style: MyText.medium(context).copyWith(
                        color: const Color(0xff808080),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
