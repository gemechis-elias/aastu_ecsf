import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/widget/circle_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class DevoationDetail extends StatefulWidget {
  final String idd;

  DevoationDetail({required this.idd});

  @override
  DevoationDetailRouteState createState() => new DevoationDetailRouteState();
}

class DevoationDetailRouteState extends State<DevoationDetail> {
  String? addedDate;
  String? author;
  String? content;
  String? image;
  String? title;

  @override
  void initState() {
    super.initState();
    loadDevotion();
  }

  void loadDevotion() {
    DatabaseReference devotionRef =
        FirebaseDatabase.instance.ref().child('blogs').child(widget.idd);

    devotionRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      dynamic value = snapshot.value;
      if (value != null && value is Map<dynamic, dynamic>) {
        setState(() {
          addedDate = value['addedDate'];
          author = value['author'];
          content = value['content'];
          image = value['image'];
          title = value['title'];
          log("Received: " + value.toString());
        });
      } else {
        log("Error devotion");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      floatingActionButton: FloatingActionButton(
        heroTag: "fab1",
        backgroundColor: const Color(0xffd1a552),
        elevation: 3,
        child: const Icon(Icons.thumb_up, color: MyColors.grey_10),
        onPressed: () {
          log('Clicked');
        },
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              brightness: Brightness.dark,
              backgroundColor: const Color(0xff121212),
              floating: true,
              pinned: false,
              snap: false,
              title: Row(
                children: <Widget>[
                  CircleImage(
                    imageProvider: AssetImage(Img.get('logo.jpg')),
                    size: 40,
                  ),
                  Container(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Devoation & Blogs",
                          style: MyText.body2(context)!
                              .copyWith(color: MyColors.grey_10)),
                      Container(height: 2),
                      Row(
                        children: <Widget>[
                          Text("$addedDate",
                              style: MyText.caption(context)!
                                  .copyWith(color: MyColors.grey_60)),
                          Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: MyColors.grey_40,
                                  borderRadius: BorderRadius.circular(15.0))),
                          Text("2 min",
                              style: MyText.caption(context)!
                                  .copyWith(color: MyColors.grey_60)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: MyColors.grey_40),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.bookmark_border,
                        color: MyColors.grey_40),
                    onPressed: () {}),
              ]),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(title ?? "Loading...",
                          style: MyText.display1(context)!.copyWith(
                              color: MyColors.grey_20,
                              fontSize: 26,
                              fontFamily: 'MyBoldFont',
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(height: 5),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("By: $author",
                          style: MyText.title(context)!.copyWith(
                              fontSize: 12,
                              fontFamily: 'MyFont',
                              color: MyColors.grey_60)),
                    ),
                    Container(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: CachedNetworkImage(
                        imageUrl: image ??
                            "https://i.pinimg.com/originals/80/b5/81/80b5813d8ad81a765ca47ebc59a65ac3.jpg",
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 24, // Adjust the size as needed
                            height: 24, // Adjust the size as needed
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(height: 5),
                    Container(
                      alignment: Alignment.center,
                      child: Text("AASTU ECSF",
                          textAlign: TextAlign.center,
                          style: MyText.caption(context)!
                              .copyWith(color: MyColors.grey_40)),
                    ),
                    Container(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        content ?? 'Loading..',
                        textAlign: TextAlign.justify,
                        style: MyText.medium(context).copyWith(
                          fontSize: 17,
                          fontFamily: 'MyFont',
                          color: MyColors.grey_40,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 15),
                        Text("3,556 Likes",
                            textAlign: TextAlign.center,
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_80)),
                        const Spacer(),
                        IconButton(
                            icon: const Icon(Icons.more_vert,
                                color: MyColors.grey_60),
                            onPressed: () {}),
                      ],
                    ),
                    Container(height: 50),
                  ],
                ),
              );
            }, childCount: 1),
          )
        ],
      ),
    );
  }
}
