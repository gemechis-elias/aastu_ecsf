import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DevotionDetail extends StatefulWidget {
  final String idd;
  final String link;
  const DevotionDetail({Key? key, required this.idd, required this.link})
      : super(key: key);

  @override
  _DevotionDetailState createState() => _DevotionDetailState();
}

class _DevotionDetailState extends State<DevotionDetail> {
  String? addedDate;
  String? title;
  String? devo_link;

  double _progress = 0;
  late InAppWebViewController webViewController;

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
          title = value['title'];
          devo_link = value['content'];
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
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.jpg'),
              radius: 20,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Daily Devotion",
                  style: TextStyle(
                    fontFamily: 'MyBoldFont',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  addedDate ?? "Connecting to VPN...",
                  style: TextStyle(
                    fontFamily: 'MyFont',
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
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
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.link)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
          ),
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
          webViewController.evaluateJavascript(source: '''
  var style = document.createElement('style');
  style.type = 'text/css';
  style.innerHTML = `
    /* Background */
    body {
      background-color: #202020;
    }

    /* Main text color */
    .tl_article .tl_article_content, .tl_article .tl_article_content .ql-editor * {
      color: #f3f4f8;
    }

    .tl_article h1, .tl_article h2, .tl_article .tl_article_content, .tl_article .tl_article_content {
      color: #79828B;
    }

    /* The color of the side of the text */
    .tl_article.tl_article_edit.title_focused [data-label]:after {
      color: #f3f4f8;
    }

    /* The publish and edit button */
    .tl_article_edit .publish_button, .tl_article_saving .publish_button, .tl_article .share_button, .tl_article_editable .edit_button {
      color: white;
      background-color: #404040;
    }
  `;
  document.getElementsByTagName('head')[0].appendChild(style);
''');
        },
        onLoadStart: (controller, url) {
          // Enable dark mode
          webViewController.evaluateJavascript(source: '''
  var style = document.createElement('style');
  style.type = 'text/css';
  style.innerHTML = `
    /* Background */
    body {
      background-color: #202020;
    }

    /* Main text color */
    .tl_article .tl_article_content, .tl_article .tl_article_content .ql-editor * {
      color: #f3f4f8;
    }

    .tl_article h1, .tl_article h2, .tl_article .tl_article_content, .tl_article .tl_article_content {
      color: #79828B;
    }

    /* The color of the side of the text */
    .tl_article.tl_article_edit.title_focused [data-label]:after {
      color: #f3f4f8;
    }

    /* The publish and edit button */
    .tl_article_edit .publish_button, .tl_article_saving .publish_button, .tl_article .share_button, .tl_article_editable .edit_button {
      color: white;
      background-color: #404040;
    }
  `;
  document.getElementsByTagName('head')[0].appendChild(style);
''');
        },
        onLoadError: (controller, url, code, message) {
          log('Error: $message');
        },
        onProgressChanged: (controller, progress) {
          setState(() {
            _progress = progress / 100;
          });
          webViewController.evaluateJavascript(source: '''
  var style = document.createElement('style');
  style.type = 'text/css';
  style.innerHTML = `
    /* Background */
    body {
      background-color: #202020;
    }

    /* Main text color */
    .tl_article .tl_article_content, .tl_article .tl_article_content .ql-editor * {
      color: #f3f4f8;
    }

    .tl_article h1, .tl_article h2, .tl_article .tl_article_content, .tl_article .tl_article_content {
      color: #79828B;
    }

    /* The color of the side of the text */
    .tl_article.tl_article_edit.title_focused [data-label]:after {
      color: #f3f4f8;
    }

    /* The publish and edit button */
    .tl_article_edit .publish_button, .tl_article_saving .publish_button, .tl_article .share_button, .tl_article_editable .edit_button {
      color: white;
      background-color: #404040;
    }
  `;
  document.getElementsByTagName('head')[0].appendChild(style);
''');
        },
      ),
    );
  }
}
