import 'dart:developer';

import 'package:aastu_ecsf/route/gallery/gallary_adapter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/model/section_image.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

class GalleryFiltered extends StatefulWidget {
  final String year;
  final String tag;

  GalleryFiltered({required this.tag, required this.year});

  @override
  GridSectionedRouteState createState() => new GridSectionedRouteState();
}

class GridSectionedRouteState extends State<GalleryFiltered> {
  late DatabaseReference _databaseReference;
  Map<String, List<Map<dynamic, dynamic>>> _galleryItems = {};

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('gallery-posts');
    _databaseReference.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        dynamic value = snapshot.value;
        if (value is Map<dynamic, dynamic>) {
          Map<String, List<Map<dynamic, dynamic>>> items = {};
          value.forEach((key, fetchData) {
            Map<dynamic, dynamic> item = {
              'id': key,
              'description': fetchData['description'],
              'images': fetchData['images'],
              'tag': fetchData['tag'],
              'year': fetchData['year'],
            };
            String tag = fetchData['description'];
            if (!items.containsKey(tag)) {
              items[tag] = [];
            }
            items[tag]!.add(item);
          });
          setState(() {
            _galleryItems = items;
          });
        }
      }
    });
  }

  void onItemClick(int index, String obj) {
    MyToast.show(obj, context, duration: MyToast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    List<SectionImage> items = [];

    _galleryItems.forEach((tag, itemList) {
      List<SectionImage> sectionItems = [];
      itemList.forEach((item) {
        String y = widget.year;
        log("Filtered Year: $y");
        if (item['year'] == y) {
          List<dynamic> images = item['images'];
          for (var image in images) {
            sectionItems.add(SectionImage(image, item['description'], false));
          }
        }
      });
      if (sectionItems.isNotEmpty) {
        // add this condition
        items.add(SectionImage("", tag, true));
        items.addAll(sectionItems);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Fellowship Gallery',
          style: TextStyle(
            fontFamily: 'MyBoldFont',
            color: Colors.white,
          ),
        ),
      ),
      body: GridSectionedAdapter(items, onItemClick).getView(),
    );
  }
}
