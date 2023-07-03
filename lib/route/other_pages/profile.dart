import 'dart:developer';

import 'package:aastu_ecsf/app_theme.dart';
import 'package:aastu_ecsf/route/auth/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePolygonRoute extends StatefulWidget {
  ProfilePolygonRoute();

  @override
  ProfilePolygonRouteState createState() => ProfilePolygonRouteState();
}

class ProfilePolygonRouteState extends State<ProfilePolygonRoute> {
  String photoUrl = "assets/images/user.png"; // Initialize with null
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
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseDatabase.instance.ref();
    log("User ID: $userId");
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
        joinedDate =
            data['joinedDate'] ?? ''; // Update the photoUrl from the data
      });
      log("User Info${snapshot.value}");
      log("User ID: $userId");
    } else {
      log('No data available.');
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    final ref = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await ref.child('users/$userId').update({'photoUrl': imageUrl});

    setState(() {
      photoUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              // brightness: Brightness.dark,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFCA7754),
                          Color(0xFFE23936),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
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
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: Text('Upload Profile Picture'),
                    //         content: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Text('Choose an image to upload'),
                    //             // Add a widget to choose an image here, e.g., ImagePicker
                    //             // You can use packages like image_picker or file_picker for this.
                    //           ],
                    //         ),
                    //         actions: [
                    //           ElevatedButton(
                    //             child: Text('Upload'),
                    //             onPressed: () {
                    //               // Handle the upload functionality here
                    //               // Update the user's profile information with the new image
                    //               // Close the dialog
                    //               String imageUrl =
                    //                   ""; // Replace with the uploaded image URL
                    //               updateProfileImage(imageUrl);
                    //               Navigator.pop(context);
                    //             },
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   );
                  },
                ),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    try {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginSimpleDarkRoute(),
                        ),
                      );
                    } catch (e) {
                      log('Error signing out: $e');
                    }
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
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  transform: Matrix4.translationValues(0, 50, 0),
                  child: ClipOval(
                    child: SizedBox(
                      width: 96,
                      height: 96,
                      child: photoUrl != "assets/images/user.png"
                          ? CachedNetworkImage(
                              imageUrl: photoUrl,
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  width: 24, // Adjust the size as needed
                                  height: 24, // Adjust the size as needed
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : Image.asset(photoUrl),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xff1F1F1F),
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          Text(team,
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
                          Text(department,
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
                          Text(section,
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
                const Divider(height: 50),
                Container(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
