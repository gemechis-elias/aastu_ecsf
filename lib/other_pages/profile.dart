import 'dart:developer';

import 'package:aastu_ecsf/login.dart';
import 'package:aastu_ecsf/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class ProfilePolygonRoute extends StatefulWidget {
  ProfilePolygonRoute();

  @override
  ProfilePolygonRouteState createState() => ProfilePolygonRouteState();
}

class ProfilePolygonRouteState extends State<ProfilePolygonRoute> {
  String photoUrl = ""; // Initialize with an empty string
  String name = '';
  String bio = '';
  String role = '';
  String department = '';
  String section = '';
  String team = '';
  String email = '';
  String joinedDate = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    log("ProfileRouteState: fetchData() called");
    final ref = FirebaseDatabase.instance.ref();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;

    final snapshot = await ref.child('users/$userId').get();
    final Map<dynamic, dynamic>? data =
        snapshot.value as Map<dynamic, dynamic>?;

    if (snapshot.exists) {
      setState(() {
        name = data!['name'] ?? '';
        bio = data['bio'] ?? '';
        role = data['role'] ?? '';
        department = data['department'] ?? '';
        section = data['section'] ?? '';
        team = data['team'] ?? '';
        email = data['email'] ?? '';
        joinedDate = data['joinedDate'] ?? '';
      });
      log("User Info${snapshot.value}");
      log("User ID: $userId");
    } else {
      log('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F1F1F),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              brightness: Brightness.dark,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    Image.asset(Img.get('bg_polygon.png'), fit: BoxFit.cover),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                // overflow menu
                PopupMenuButton<String>(
                  onSelected: (String value) async {
                    await FirebaseAuth.instance.signOut();
                    // Use pushReplacement instead of push
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginSimpleDarkRoute(),
                      ),
                    );
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "Logout",
                      child: Text("Logout"),
                    ),
                  ],
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Container(
                  transform: Matrix4.translationValues(0, 50, 0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xff1F1F1F),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(Img.get("user.png")),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xff1F1F1F),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(height: 70),
                Text(name,
                    style: MyText.headline(context)!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Container(height: 15),
                Text(bio,
                    textAlign: TextAlign.center,
                    style:
                        MyText.subhead(context)!.copyWith(color: Colors.white)),
                Container(height: 25),
                Container(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text("I4U",
                              style: MyText.title(context)!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Container(height: 5),
                          Text("Team",
                              style: MyText.subhead(context)!
                                  .copyWith(color: Colors.grey[600]))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text("Electrical",
                              style: MyText.title(context)!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Container(height: 5),
                          Text("Department",
                              style: MyText.subhead(context)!
                                  .copyWith(color: Colors.grey[600]))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text("B",
                              style: MyText.title(context)!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Container(height: 5),
                          Text("Section",
                              style: MyText.subhead(context)!
                                  .copyWith(color: Colors.grey[600]))
                        ],
                      ),
                    ),
                  ],
                ),
                Container(height: 35),
                Divider(height: 50),
                Container(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
