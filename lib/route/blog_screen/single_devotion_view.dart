import 'dart:developer';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/widget/circle_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DevoationDetail extends StatefulWidget {
  final String idd;
  final String link;
  const DevoationDetail({super.key, required this.idd, required this.link});

  @override
  DevoationDetailRouteState createState() => DevoationDetailRouteState();
}

class DevoationDetailRouteState extends State<DevoationDetail> {
  String? addedDate;
  String? author;
  String? content;
  String? image;
  String? title;
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  void initState() {
    super.initState();
    loadDevotion();
  }

  void loadDevotion() {
    DatabaseReference devotionRef =
        FirebaseDatabase.instance.ref().child('blogs').child(widget.idd);

    devotionRef.onValue.listen((event) {
      if (event.snapshot.value != null &&
          event.snapshot.value is Map<dynamic, dynamic>) {
        DataSnapshot snapshot = event.snapshot;
        dynamic value = snapshot.value;

        setState(() {
          addedDate = value['addedDate'];
          author = value['author'];
          content = value['content'];
          image = value['image'];
          title = value['title'];
          log("Devotion Title: $title");
          log("Devotion Link: $content");
        });
      } else {
        log("Error: Invalid devotion data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1f1f1f),
        appBar: AppBar(
          backgroundColor: const Color(0xff121212),
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
                  Text(
                    "Daily Devotion",
                    style: MyText.medium(context).copyWith(color: Colors.white),
                  ),
                  Container(height: 2),
                  Text(
                    addedDate ?? "Connecting to VPN...",
                    style: MyText.caption(context)!
                        .copyWith(color: MyColors.grey_10),
                  ),
                ],
              )
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {},
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "Save",
                  child: Text("Save"),
                ),
              ],
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            var isLastPage = await inAppWebViewController.canGoBack();

            if (isLastPage) {
              inAppWebViewController.goBack();
              return false;
            }

            return true;
          },
          child: SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.link)),
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                        forceDark: AndroidForceDark.FORCE_DARK_ON,
                      ),
                      crossPlatform: InAppWebViewOptions(
                        preferredContentMode:
                            UserPreferredContentMode.RECOMMENDED,
                        javaScriptEnabled: true,
                      ),
                    ),
                    onWebViewCreated:
                        (InAppWebViewController controller) async {
                      inAppWebViewController = controller;
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        _progress = progress / 100;
                      });
                    },
                  ),
                  _progress < 1
                      ? LinearProgressIndicator(
                          value: _progress,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> enableDarkMode() async {
    const darkModeCss = '''
      var style = document.createElement('style');
      style.type = 'text/css';
      style.innerHTML = 'body { background-color: #000000; color: #ffffff; }';
      document.getElementsByTagName('head')[0].appendChild(style);
    ''';

    await inAppWebViewController.evaluateJavascript(source: darkModeCss);
  }
}
