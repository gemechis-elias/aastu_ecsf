import 'dart:developer';
import 'dart:ui';

import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/home_screen/video_model.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_list.dart';

/// Homepage
class YoutubePlayerDemoApp extends StatefulWidget {
  final String ids;
  const YoutubePlayerDemoApp({super.key, required this.ids});

  @override
  YoutubePlayerDemoAppState createState() => YoutubePlayerDemoAppState();
}

class YoutubePlayerDemoAppState extends State<YoutubePlayerDemoApp> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('videos');
  List<Map<dynamic, dynamic>> videos = [];

  void loadVideos() {
    log("Loading Videos...");
    databaseReference.onValue.listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        dynamic value = snapshot.value;
        if (value is Map<dynamic, dynamic>) {
          List<Map<dynamic, dynamic>> videos = [];

          value.forEach((key, VideoData) {
            Map<dynamic, dynamic> video = {
              'id': key,
              'description': VideoData['description'],
              'link': VideoData['link'],
              'thumbnail': VideoData['thumbnail'],
              'title': VideoData['title'],
              'date': VideoData['addedDate'],
            };
            videos.add(video);
          });
          setState(() {
            this.videos = videos;

            log("Videos loaded!");

            // print id
            log("ID: " + videos[0]['id']);
          });
        } else {
          // Handle the case when `snapshot.value` is not a Map<dynamic, dynamic>
          log("Can't Iterate Snapshot");
        }
      } else {
        // Handle the case when `snapshot.value` is null
        log("Can't load Videosdata");
      }
    });
  }

  // List<VideoData> videos = [
  //   VideoData(
  //     title: "Menfes Kidus",
  //     imagePath: "concert2014_3.jpg",
  //     date: "May 3, 2023",
  //     views: "Hana Yoseph",
  //     videoUrl: "",
  //   ),
  //   VideoData(
  //     title: "Tetemtenal",
  //     imagePath: "concert2014_5.jpg",
  //     date: "May 3, 2023",
  //     views: "Worship Team",
  //     videoUrl: "",
  //   ),
  //   VideoData(
  //     title: "Tekeblonal Concert",
  //     imagePath: "concert2014_6.jpg",
  //     date: "May 3, 2023",
  //     views: "Adonias",
  //     videoUrl: "",
  //   ),
  //   VideoData(
  //     title: "Worship Time",
  //     imagePath: "concert2014_1.jpg",
  //     date: "May 3, 2023",
  //     views: "Choir Team",
  //     videoUrl: "",
  //   ),
  //   // add more video data objects as necessary
  // ];
//  final List<String> _ids = [
//     'R6EQHdDwME8',
//     'WI2kGeS4ys0',
//     'XoVHaDFd1os',
//     'L1g-rQCHT18',
//     'PKSae36GMjY',
//   ];
  @override
  void initState() {
    super.initState();

    loadVideos();
    _controller = YoutubePlayerController(
      initialVideoId: widget.ids,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  String? extractYouTubeVideoId(String youtubeUrl) {
    RegExp regExp = RegExp(
      r"(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/|y2u\.be\/)([a-zA-Z0-9_-]{11})",
      caseSensitive: false,
      multiLine: false,
    );

    Match? match = regExp.firstMatch(youtubeUrl);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }

    return "R6EQHdDwME8"; // Return null if the video ID couldn't be extracted
  }

  @override
  Widget build(BuildContext context) {
    // Assuming that _videoMetaData.duration is a Duration object
    int totalSeconds = _videoMetaData.duration.inSeconds;
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    String durationString =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} min';

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behavior.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 23.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },

        // onEnded: (data) {
        //   _controller
        //       .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
        //   _showSnackBar('Next Video Started!');
        // },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          // brightness: Brightness.dark,
          backgroundColor: const Color(0xff121212),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Videos',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.video_library),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => VideoList(),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: const Color(0xff1f1f1f),
          child: ListView(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _videoMetaData.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'MyBoldFont',
                      ),
                    ),
                    Text(
                      _videoMetaData.author,
                      style: const TextStyle(
                        color: Color(0xff808080),
                        fontSize: 13,
                        fontFamily: 'MyBoldFont',
                      ),
                    ),
                    Text(
                      durationString,
                      style: const TextStyle(
                        color: Color(0xff808080),
                        fontSize: 13,
                        fontFamily: 'MyBoldFont',
                      ),
                    ),
                    _space,
                    const Divider(
                      height: 2,
                      thickness: 1,
                      color: Color.fromARGB(188, 189, 189, 189),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "Related Videos",
                        style: TextStyle(
                          fontFamily: 'MyFont',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 500, // Set a fixed height for the GridView
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return CardsUI(
                            title: videos[index]['title'],
                            thumbnail: videos[index]['thumbnail'],
                            date: videos[index]['date'],
                            description: videos[index]['description'],
                            link: videos[index]['link'],
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 145 / 160,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CardsUI({
    required String title,
    required String thumbnail,
    required String date,
    required String description,
    required String link,
  }) {
    return InkWell(
      onTap: () {
        String? link_id = extractYouTubeVideoId(link);

        if (link_id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YoutubePlayerDemoApp(
                ids: link_id,
              ),
            ),
          );
        } else {
          log('Invalid YouTube URL: Loading Default Video');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const YoutubePlayerDemoApp(
                ids: "R6EQHdDwME8",
              ),
            ),
          );
        }
      },
      child: Hero(
        tag: title,
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Card(
            color: const Color(0xff212121),
            margin: const EdgeInsets.all(0),
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: thumbnail,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 24, // Adjust the size as needed
                          height: 24, // Adjust the size as needed
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 30),
                    child: Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: const Color.fromARGB(255, 128, 128, 128)
                                .withOpacity(0.2),
                            child: IconButton(
                              icon: const Icon(Icons.play_circle_fill),
                              color: Colors.white,
                              onPressed: () {
                                // Add your onPressed code here
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: 'MyFont',
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      description,
                      maxLines: 1,
                      style: const TextStyle(
                        fontFamily: 'MyLightFont',
                        color: Color(0xff808080),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontFamily: 'MyLightFont',
                        color: Color(0xff808080),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
