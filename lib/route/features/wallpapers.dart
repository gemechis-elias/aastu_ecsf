import 'dart:developer';
import 'dart:io';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:dio/dio.dart';
import 'package:aastu_ecsf/route/features/wallpaper_adapter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class WallpaperBasicRoute extends StatefulWidget {
  const WallpaperBasicRoute({Key? key}) : super(key: key);

  @override
  WallpaperBasicRouteState createState() => WallpaperBasicRouteState();
}

class WallpaperBasicRouteState extends State<WallpaperBasicRoute> {
  late DatabaseReference _databaseReference;
  List<Map<dynamic, dynamic>> items = [];
  List<String> images = [];

  void onItemClick(int index, String obj) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            WallpaperFullScreenRoute(images: images, currentIndex: index),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('wallpaper');

    _databaseReference.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        dynamic value = snapshot.value;
        if (value is Map<dynamic, dynamic>) {
          List<Map<dynamic, dynamic>> newItems = [];
          value.forEach((key, fetchData) {
            Map<dynamic, dynamic> item = {
              'id': key,
              'image': fetchData['image'],
            };
            newItems.add(item);
          });
          setState(() {
            items = newItems;
            images = items
                .map<String>((item) => item['image'])
                .toList()
                .reversed
                .toList();
            log("Wallpapers: $images");
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Wallpapers',
          style: TextStyle(
            fontFamily: 'MyFont',
            color: Colors.white,
          ),
        ),
      ),
      body: WallpaperAdapter(images, onItemClick).getView(onItemClick),
    );
  }
}

class WallpaperFullScreenRoute extends StatefulWidget {
  final List<String> images;
  final int currentIndex;

  const WallpaperFullScreenRoute({
    super.key,
    required this.images,
    required this.currentIndex,
  });

  @override
  // ignore: library_private_types_in_public_api
  _WallpaperFullScreenRouteState createState() =>
      _WallpaperFullScreenRouteState();
}

class _WallpaperFullScreenRouteState extends State<WallpaperFullScreenRoute> {
  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          //Navigator.pop(context);
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: widget.images[index],
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        width: 24, // Adjust the size as needed
                        height: 24, // Adjust the size as needed
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                onPressed: () {
                  final String currentImage = widget.images[currentIndex];
                  _save(currentImage);
                  MyToast.show("Downloading...", context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save(String imgPath) async {
    await _askPermission();
    var response = await Dio()
        .get(imgPath, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    // Show a toast or any other notification to indicate that the image is saved
    showNotification("Wallpaper is saved to Gallery");
    Navigator.pop(context);
  }

  Future<void> _askPermission() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.request();
      if (status.isDenied) {
        // Permission denied.
        // Show a toast or any other notification to indicate that the permission is required to save the image.
        MyToast.show("Please, Give a Permission", context);
      }
    } else {
      var status = await Permission.storage.request();
      if (status.isDenied) {
        // Permission denied.
        // Show a toast or any other notification to indicate that the permission is required to save the image.
        MyToast.show("Please, Give a Permission", context);
      }
    }
  }

  void showNotification(String message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'com.aastu.ecsf.aastu_ecsf',
      'Local Notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Downloaded!',
      message,
      platformChannelSpecifics,
    );
  }
}
