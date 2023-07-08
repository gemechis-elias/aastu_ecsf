import 'package:aastu_ecsf/route/blog_screen/single_blog_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/route/blog_screen/blog_list_adapter.dart';
import 'package:aastu_ecsf/model/blog_model.dart';

import 'dart:developer';

class ListNewsLightRoute extends StatefulWidget {
  const ListNewsLightRoute({super.key});

  @override
  ListNewsLightRouteState createState() => ListNewsLightRouteState();
}

class ListNewsLightRouteState extends State<ListNewsLightRoute> {
  List<Blog> items = [];

  final database = FirebaseDatabase.instance.ref().child('devotions');
  @override
  void initState() {
    super.initState();

    log("Blog Page Started");
    loadBlogsFromFirebase();
  }

  Future<void> loadBlogsFromFirebase() async {
    log("Loading Blogs...");
    try {
      database.onValue.listen((event) {
        final snapshot = event.snapshot;

        if (snapshot.value != null) {
          final Map<dynamic, dynamic>? data =
              snapshot.value as Map<dynamic, dynamic>?;

          if (data != null) {
            final List<Blog> loadedBlogs = data.entries.map((entry) {
              final String id = entry.key;
              final Map<dynamic, dynamic> blogData =
                  entry.value as Map<dynamic, dynamic>;
              return Blog(
                id: id,
                image: blogData['image'] ?? '',
                title: blogData['title'] ?? '',
                author: blogData['author'] ?? '',
                date: blogData['addedDate'] ?? '',
                description: blogData['content'] ?? '',
              );
            }).toList();
            setState(() {
              this.items = loadedBlogs;
              log("Received Blog: " + loadedBlogs.toString());
            });
          }
        }
      });
    } catch (e) {
      log("Error loading blogs: $e");
    }
  }

  void onItemClick(int index, Blog obj) {
    if (index >= 0 && index < items.length) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => BlogDetail(
            idd: obj.id,
            link: obj.description,
          ),
        ),
      );
    } else {
      log('Invalid index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xff121212),
            centerTitle: false,
            title: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xffd1a552), Color.fromARGB(255, 209, 150, 82)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                "Blogs",
                style: TextStyle(
                  fontFamily: 'MyBoldFont',
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BlogListAdapter(items, onItemClick).getView(),
        ],
      ),
    );
  }
}
