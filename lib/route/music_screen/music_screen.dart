// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:aastu_ecsf/route/music_screen/music_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  String baseURL = "https://dagmawibabi.com/AASTUECSFAPP/";
  List songs = [];

  final player = AudioPlayer();
  late dynamic duration;
  late Stream<Duration?> positionStream;
  bool isPlaying = false;
  bool isSongLoaded = false;
  bool isLoading = false;
  Map currentPlayingSong = {
    "albumArt": "",
    "title": "Worship Wave",
  };

  String sampleSongUrl = 'Dawit Getachew/Aminhalew/Efeligihalew.mp3';

  Future<void> loadMusic(String url) async {
    isLoading = true;
    isSongLoaded = false;
    setState(() {});
    duration = await player.setUrl(baseURL + url);
    log("${baseURL + url}");
    positionStream = player.positionStream;
    isSongLoaded = true;
    isLoading = false;
    setState(() {});
    log("SONG LOADED!");
    await playMusic();
  }

  Future<void> playMusic() async {
    isPlaying = true;
    setState(() {});
    await player.play(); // Play while waiting for completion
    log("SONG PLAYING!");
  }

  Future<void> pauseMusic() async {
    isPlaying = false;
    setState(() {});
    await player.pause();
    log("SONG PAUSED!");
  }

  Future<void> stopMusic() async {
    isPlaying = false;
    setState(() {});
    isPlaying = false;
    isSongLoaded = false;
    isLoading = false;
    currentPlayingSong = {
      "albumArt": "",
      "title": "Zimrath Player",
    };
    await player.stop();
    log("SONG STOPPED!");
  }

  void showAlbumSongList(Map albumData) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 2.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xff101010),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      albumData["title"],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      albumData["artist"],
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    for (var eachSong in albumData["songs"])
                      GestureDetector(
                        onTap: () async {
                          currentPlayingSong["albumArt"] =
                              albumData["albumArt"];
                          currentPlayingSong["title"] = eachSong
                              .toString()
                              .substring(0, eachSong.length - 4);
                          setState(() {});
                          Navigator.pop(context);
                          String songURL =
                              "Albums/${albumData["artist"]} ${albumData["title"]}/${eachSong}";
                          await loadMusic(songURL);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                eachSong
                                    .toString()
                                    .substring(0, eachSong.length - 4),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: currentPlayingSong["title"] ==
                                          eachSong
                                              .toString()
                                              .substring(0, eachSong.length - 4)
                                      ? Colors.greenAccent
                                      : Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.play_arrow,
                                color: currentPlayingSong["title"] ==
                                        eachSong
                                            .toString()
                                            .substring(0, eachSong.length - 4)
                                    ? Colors.greenAccent
                                    : Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 100.0),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAlbumArt() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 2.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xff101010),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              width: 40.0,
              height: 40.0,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: CachedNetworkImage(
                width: 100.0,
                height: 200.0,
                imageUrl: currentPlayingSong["albumArt"],
                progressIndicatorBuilder: (context, string, progress) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                },
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  bool isGettingSongs = true;
  void getSongs() async {
    final dio = Dio();
    Response result = await dio.get("${baseURL}songs.json");
    // log(result);
    print(result);
    songs = result.data as List;
    isGettingSongs = false;
    setState(() {});
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await player.stop();
    await player.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900]!,
      appBar: AppBar(
        title: Row(
          children: [
            currentPlayingSong["albumArt"] != ""
                ? GestureDetector(
                    onTap: () {
                      showAlbumArt();
                    },
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      child: CachedNetworkImage(
                        width: 40.0,
                        height: 40.0,
                        imageUrl: currentPlayingSong["albumArt"],
                        progressIndicatorBuilder: (context, string, progress) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Icon(
                    Icons.music_note,
                  ),
            SizedBox(width: 10.0),
            Expanded(
              // width: 300.0,
              // color: Colors.red,
              child: Text(
                currentPlayingSong["title"].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
        actions: isSongLoaded == true
            ? [
                Row(
                  children: [
                    isPlaying == true
                        ? IconButton(
                            onPressed: () async {
                              await pauseMusic();
                            },
                            icon: Icon(
                              Icons.pause,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              await playMusic();
                            },
                            icon: Icon(
                              Icons.play_arrow,
                            ),
                          ),
                    IconButton(
                      onPressed: () async {
                        await stopMusic();
                      },
                      icon: Icon(
                        Icons.stop,
                      ),
                    ),
                  ],
                ),
              ]
            : [
                isLoading == true
                    ? Container(
                        width: 45.0,
                        height: 40.0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                            strokeWidth: 2.0,
                          ),
                        ),
                      )
                    : Container(),
              ],
        bottom: isSongLoaded == true
            ? PreferredSize(
                // preferredSize: Size.fromHeight(50.0),
                preferredSize: Size(200.0, 40.0),
                child: StreamBuilder(
                  stream: positionStream,
                  builder: (context, snapshot) {
                    Duration? positionData = snapshot.data;
                    // log(positionData.toString());
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          positionData != null
                              ? Text(
                                  "${"${positionData.inSeconds ~/ 60}".toString().padLeft(2, '0')}:${"${(positionData.inSeconds % 60).toInt()}".toString().padLeft(2, "0")}",
                                )
                              : Container(),
                          positionData != null
                              ? Expanded(
                                  child: Slider(
                                    thumbColor: Colors.white,
                                    activeColor: Colors.blue,
                                    inactiveColor:
                                        Colors.orange.withOpacity(0.2),
                                    value: positionData.inSeconds.toDouble(),
                                    min: 0.0,
                                    max: duration.inSeconds.toDouble(),
                                    onChanged: (value) async {
                                      await player.seek(
                                        Duration(
                                          seconds: value.toInt(),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Slider(
                                  thumbColor: Colors.white,
                                  activeColor: Colors.blue,
                                  inactiveColor: Colors.orange.withOpacity(0.2),
                                  value: 0.0,
                                  min: 0.0,
                                  max: 100.0,
                                  onChanged: (value) {},
                                ),
                          Text(
                            "${"${duration.inSeconds ~/ 60}".toString().padLeft(2, '0')}:${"${(duration.inSeconds % 60).toInt()}".toString().padLeft(2, "0")}",
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            : PreferredSize(
                preferredSize: Size(200.0, 0.0),
                child: Container(),
              ),
      ),
      body: ListView(
        children: [
          isGettingSongs == true
              ? Container(
                  height: 300.0,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Picks
                      Text(
                        "Top Picks",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 225.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var eachCategory in songs)
                              if (eachCategory["category"]
                                      .toString()
                                      .toLowerCase() ==
                                  "top picks")
                                for (var eachAlbum in eachCategory["list"])
                                  GestureDetector(
                                    onTap: () async {
                                      currentPlayingSong["albumArt"] =
                                          eachAlbum["albumArt"];
                                      currentPlayingSong["title"] =
                                          eachAlbum["title"];
                                      setState(() {});
                                      await loadMusic(eachAlbum["link"]);
                                    },
                                    child: MusicContainer(
                                      albumData: eachAlbum,
                                    ),
                                  ),
                          ],
                        ),
                      ),

                      // Albums
                      Text(
                        "Albums",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 225.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var eachCategory in songs)
                              if (eachCategory["category"]
                                      .toString()
                                      .toLowerCase() ==
                                  "albums")
                                for (var eachAlbum in eachCategory["list"])
                                  GestureDetector(
                                    onTap: () {
                                      showAlbumSongList(eachAlbum);
                                    },
                                    child: MusicContainer(
                                      albumData: eachAlbum,
                                    ),
                                  ),
                          ],
                        ),
                      ),

                      // New Songs
                      Text(
                        "New Songs",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 225.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var eachCategory in songs)
                              if (eachCategory["category"]
                                      .toString()
                                      .toLowerCase() ==
                                  "new songs")
                                for (var eachAlbum in eachCategory["list"])
                                  GestureDetector(
                                    onTap: () async {
                                      currentPlayingSong["albumArt"] =
                                          eachAlbum["albumArt"];
                                      currentPlayingSong["title"] =
                                          eachAlbum["title"];
                                      setState(() {});
                                      await loadMusic(eachAlbum["link"]);
                                    },
                                    child: MusicContainer(
                                      albumData: eachAlbum,
                                    ),
                                  ),
                          ],
                        ),
                      ),

                      // Singles
                      Text(
                        "Singles",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 225.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var eachCategory in songs)
                              if (eachCategory["category"]
                                      .toString()
                                      .toLowerCase() ==
                                  "singles")
                                for (var eachAlbum in eachCategory["list"])
                                  GestureDetector(
                                    onTap: () async {
                                      currentPlayingSong["albumArt"] =
                                          eachAlbum["albumArt"];
                                      currentPlayingSong["title"] =
                                          eachAlbum["title"];
                                      setState(() {});
                                      await loadMusic(eachAlbum["link"]);
                                    },
                                    child: MusicContainer(
                                      albumData: eachAlbum,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
