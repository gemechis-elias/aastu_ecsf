import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/route/other_pages/wallpaper_adapter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

enum WallpaperLocation {
  HomeScreen,
  LockScreen,
  BothScreens,
}

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
            images = items.map<String>((item) => item['image']).toList();
            log("Wallpapers: $images");
          });
        }
      }
    });
  }

  List<String> getNatureImages() {
    List<String> natureImages = [];
    for (String s in images) {
      natureImages.add(s);
    }
    natureImages = natureImages.reversed.toList();
    return natureImages;
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = getNatureImages();

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
            color: Colors.white,
          ),
        ),
      ),
      body: WallpaperAdapter(items, onItemClick).getView(onItemClick),
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
                  Icons.wallpaper,
                  color: Colors.black,
                ),
                onPressed: () {
                  final String currentImage = widget.images[currentIndex];
                  setWallpaper(currentImage, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _save(String imgPath) async {
    await _askPermission();
    var response = await Dio()
        .get(imgPath, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    log(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      var status = await Permission.photos.status;
      if (status.isDenied) {
        // We didn't ask for permission yet or the permission has been denied before but not permanently.
      }
      // await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    } else {
      // /* PermissionStatus permission = */ await PermissionHandler()
      //     .checkPermissionStatus(PermissionGroup.storage);
    }
  }

  Future<void> setWallpaper(String imageUrl, BuildContext context) async {
    try {
      final url = imageUrl;
      final file = await DefaultCacheManager().getSingleFile(url);
      // ignore: use_build_context_synchronously
      WallpaperLocation? selectedLocation = await showDialog<WallpaperLocation>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: MyColors.grey_90,
            title: const Text('Set Wallpaper'),
            content: const Text('Select wallpaper location:'),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Home Screen',
                  style: TextStyle(color: Color(0xffd1a552)),
                ),
                onPressed: () {
                  Navigator.of(context).pop(WallpaperLocation.HomeScreen);
                },
              ),
              TextButton(
                child: const Text(
                  'Lock Screen',
                  style: TextStyle(color: Color(0xffd1a552)),
                ),
                onPressed: () {
                  Navigator.of(context).pop(WallpaperLocation.LockScreen);
                },
              ),
              TextButton(
                child: const Text(
                  'Both Screens',
                  style: TextStyle(color: Color(0xffd1a552)),
                ),
                onPressed: () {
                  Navigator.of(context).pop(WallpaperLocation.BothScreens);
                },
              ),
            ],
          );
        },
      );

      if (selectedLocation != null) {
        int location;
        switch (selectedLocation) {
          case WallpaperLocation.HomeScreen:
            location = WallpaperManager.HOME_SCREEN;
            break;
          case WallpaperLocation.LockScreen:
            location = WallpaperManager.LOCK_SCREEN;
            break;
          case WallpaperLocation.BothScreens:
            location = WallpaperManager.BOTH_SCREEN;
            break;
        }

        // Set wallpaper using the cropped image
        final bool result = await WallpaperManager.setWallpaperFromFile(
          file.path,
          location,
        );

        if (result) {
          // ignore: use_build_context_synchronously
          MyToast.show("Wallpaper set successfully", context);
          showNotification("Your wallpaper has been changed");
          log("Wallpaper set successfully");
        } else {
          // ignore: use_build_context_synchronously
          // ignore: use_build_context_synchronously
          MyToast.show("Failed to set wallpaper", context);
          log("Failed to set wallpaper");
        }
      }
    } on PlatformException {
      MyToast.show("Failed to Download wallpaper", context);
      log("Failed to get wallpaper");
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
      'Wallpaper Changed',
      message,
      platformChannelSpecifics,
    );
  }
}
