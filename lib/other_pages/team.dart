import 'dart:math';

import 'package:aastu_ecsf/data/TeamImage.dart';
import 'package:aastu_ecsf/other_pages/team_cards.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/model/team_model.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class TeamCardRoute extends StatefulWidget {
  TeamCardRoute();

  @override
  MotionCardRouteState createState() => new MotionCardRouteState();
}

class MotionCardRouteState extends State<TeamCardRoute> {
  late BuildContext _scaffoldCtx;
  bool slow = true;
  static Random random = new Random();
  void onItemClick(int index, TeamModel obj) {
    Navigator.push(
        _scaffoldCtx,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: slow ? 500 : 1000),
            pageBuilder: (_, __, ___) => MotionCardDetails(index, obj)));
    slow = !slow;
  }

  @override
  Widget build(BuildContext context) {
    List<String> cover_image = [
      "i4u.jpg",
      "worship.jpg",
      "ch4.jpg",
      "prayers.jpg",
      "outreach.jpg",
      "couseling.jpg",
      "natanims.jpg",
    ];
    List<String> cover_name = [
      "I4U Team",
      "Worship Team",
      "LAD Team",
      "Prayers Team",
      "Outreach Team",
      "Counseling Team",
      "Natanim Team",
    ];
List<String> description = [
  "The I4U Team is a charity team that focuses on helping those in need. They organize events and fundraisers to support various causes and charities in the community. In the Addis Ababa Science and Technology University Christian University Fellowship, the I4U Team works passionately to spread love and kindness to those around them. They actively engage with the community and strive to make a positive impact through their dedicated efforts.",
  "The Worship Team plays a vital role in the Christian University Fellowship meetings by leading worship and music. They create a captivating atmosphere of worship and praise, guiding the congregation in singing and prayer. Through their heartfelt performances, the Worship Team brings people closer to God and instills a sense of spiritual connection and reverence within the fellowship. Their commitment to music and worship is deeply valued and appreciated.",
  "The LAD Team (Literature, Art, and Drama) brings a creative flair to the Christian University Fellowship meetings. They organize and perform captivating skits, plays, and other dramatic performances, captivating the audience with their artistic expressions. Additionally, they contribute to the fellowship through the creation of literature and art that reflects its core values and beliefs. The LAD Team's creativity and talent breathe life into the fellowship, making it a vibrant and engaging community.",
  "The Prayers Team leads the Christian University Fellowship in prayers and intercessions during their meetings. They create a sacred space where individuals come together to pray for one another, the community, and the world. The Prayers Team plays a vital role in fostering a sense of unity and support among fellowship members. Their dedication to prayer cultivates a spirit of compassion, strength, and togetherness within the community.",
  "The Outreach Team is dedicated to spreading the gospel and sharing the love of Christ with the world. They organize impactful events and activities that help individuals draw closer to God. In the Addis Ababa Science and Technology University Christian University Fellowship, the Outreach Team actively engages with the campus and beyond, striving to bring the transformative message of Christ to the wider community. Through their welcoming and inclusive initiatives, they create an environment where everyone feels valued and accepted.",
  "The Counseling Team provides valuable counseling and support to students in the Addis Ababa Science and Technology University Christian University Fellowship. They create a safe and nurturing space where students can openly share their struggles and receive guidance and assistance. The Counseling Team's compassionate and caring approach fosters a strong sense of community and support within the fellowship, ensuring that students feel heard, understood, and uplifted.",
  "The Natanim Team plays a pivotal role in fostering a sense of unity and community within the Addis Ababa Science and Technology University Christian University Fellowship. They organize and lead various events and activities that bring people together, creating a vibrant and inclusive environment. The Natanim Team's enthusiasm and energy infuse the fellowship with joy, celebration, and a strong sense of belonging. Their efforts contribute significantly to the fellowship's overall spirit and sense of togetherness."
];


    int getRandomIndex(int max) {
      return random.nextInt(max - 1);
    }

    List<TeamModel> getMusicAlbum1() {
      List<TeamModel> items = [];
      for (int i = 0; i < cover_image.length; i++) {
        TeamModel obj = new TeamModel();
        obj.image = cover_image[i];
        obj.name = cover_name[i];
        obj.brief = "AASTU ECSF";
        obj.color = const Color(0xFFD1a552);
        obj.des = description[i];
        items.add(obj);
      }
      items.shuffle();
      return items;
    }

    List<TeamModel> items = getMusicAlbum1();

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
  final TeamModel obj;

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
                //brightness: Brightness.dark,
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
                          height: 90,
                          color: const Color(0xffc17754),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(obj.name,
                                      style: MyText.display1(context)!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Container(height: 5),
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
                  Text(obj.des,
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
