import 'dart:developer';
import 'dart:io';
import 'package:aastu_ecsf/route/auth_screen/login.dart';
import 'package:aastu_ecsf/route/user/change_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProfileRoute extends StatefulWidget {
  const UserProfileRoute({Key? key}) : super(key: key);

  @override
  UserProfileRouteState createState() => UserProfileRouteState();
}

class UserProfileRouteState extends State<UserProfileRoute> {
  String photoUrl = "assets/images/user.png";
  String name = '';
  String bio = '';
  String role = '';
  String department = '';
  String batch = '';
  String team = '';
  String email = '';
  String joinedDate = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$userId').get();
    final Map<dynamic, dynamic>? data =
        snapshot.value as Map<dynamic, dynamic>?;

    if (snapshot.exists) {
      setState(() {
        name = data!['name'] ?? '';
        bio = data['bio'] ?? '';
        photoUrl = data['photoUrl'] ?? '';
        role = data['role'] ?? '';
        department = data['department'] ?? '';
        batch = data['batch'] ?? '';
        team = data['team'] ?? '';
        email = data['email'] ?? '';
        joinedDate = data['joinedDate'] ?? '';
      });
    } else {
      log('No data available.');
    }
  }

  Future<void> refreshData() async {
    await fetchData();
  }

  Future<void> updateProfileImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage != null) {
        final croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Color(0xffd1a552),
                toolbarWidgetColor: const Color(0xff212121),
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            // ignore: use_build_context_synchronously
            WebUiSettings(
              context: context,
            ),
          ],
        );

        if (croppedImage != null) {
          final storageRef = firebase_storage.FirebaseStorage.instance
              .ref()
              .child('profile_images')
              .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

          final uploadTask = storageRef.putFile(File(croppedImage.path));
          final snapshot = await uploadTask.whenComplete(() => null);
          final downloadUrl = await snapshot.ref.getDownloadURL();

          final userId = FirebaseAuth.instance.currentUser!.uid;
          final ref = FirebaseDatabase.instance.ref();

          await ref.child('users/$userId').update({'photoUrl': downloadUrl});

          setState(() {
            photoUrl = downloadUrl;
          });
          // successfully updated alert
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 0,
            content: Card(
              color: const Color(0xff212121),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    const SizedBox(width: 5, height: 0),
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Profile Updated",
                            style: MyText.subhead(context)!.copyWith(
                                color:
                                    const Color.fromARGB(255, 255, 147, 24))),
                        Text("Your profile has been updated",
                            style: MyText.caption(context)!.copyWith(
                                color:
                                    const Color.fromARGB(255, 255, 249, 249))),
                      ],
                    )),
                    Container(
                        color: const Color.fromARGB(255, 116, 116, 116),
                        height: 35,
                        width: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 5)),
                    SnackBarAction(
                      label: "UNDO",
                      textColor: const Color.fromARGB(255, 211, 211, 211),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            duration: const Duration(seconds: 1),
          ));
        } else {
          log('Image cropping canceled.');
        }
      } else {
        log('No image selected.');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _signOut(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }

    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: NestedScrollView(
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
                      showDialog(
                          context: context,
                          builder: (_) => const ChangeProfileDialog());
                    },
                  ),
                  Builder(
                    builder: (context) => PopupMenuButton<String>(
                      onSelected: (String value) {
                        _signOut(context);
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "Logout",
                          child: Text("Logout"),
                        ),
                      ],
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    transform: Matrix4.translationValues(0, 50, 0),
                    child: Stack(
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox(
                            width: 96,
                            height: 96,
                            child: photoUrl != "assets/images/user.png" &&
                                    photoUrl != ''
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
                                : Image.asset("assets/images/user.png"),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              // Handle edit icon click
                              updateProfileImage();
                            },
                            icon: const Icon(FontAwesomeIcons.camera,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ],
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
                          fontFamily: 'MyFont',
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Container(height: 15),
                  Text(bio,
                      textAlign: TextAlign.center,
                      style: MyText.subhead(context)!
                          .copyWith(fontFamily: 'MyFont', color: Colors.white)),
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
                                    fontFamily: 'MyBoldFont',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Container(height: 5),
                            Text("Team",
                                style: MyText.subhead(context)!.copyWith(
                                    fontFamily: 'MyFont',
                                    color: Colors.grey[600]))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              department,
                              style: MyText.title(context)!.copyWith(
                                  fontFamily: 'MyBoldFont',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(height: 5),
                            Text(
                              "Department",
                              style: MyText.subhead(context)!.copyWith(
                                  fontFamily: 'MyFont',
                                  color: Colors.grey[600]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              batch,
                              style: MyText.title(context)!.copyWith(
                                  color: Colors.white,
                                  fontFamily: 'MyBoldFont',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(height: 5),
                            Text("Batch",
                                style: MyText.subhead(context)!.copyWith(
                                    fontFamily: 'MyFont',
                                    color: Colors.grey[600]))
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
      ),
    );
  }
}
