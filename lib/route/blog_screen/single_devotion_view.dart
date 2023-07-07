import 'package:flutter/material.dart';
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
        });
      } else {
        print("Error: Invalid devotion data");
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
        initialUrlRequest: URLRequest(
            url: Uri.parse(
                "https://telegra.ph/Weekly-Story---Section-B--C-Small-Group-04-11")),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
          ),
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          // Enable dark mode
          webViewController.evaluateJavascript(source: '''
  var style = document.createElement('style');
  style.type = 'text/css';
  style.innerHTML = 'body { background-color:#1f1f1f; color: #ffffff; }'+
                     'label,th,p,a,td,tr,li,ul,span,table,h1,h2,h3,h4,h5,h6,h7,div,small {'+
                     '  color: #FFFFFF;'+
                     '}';
  document.getElementsByTagName('head')[0].appendChild(style);
''');
        },
        onLoadError: (controller, url, code, message) {
          print('Error: $message');
        },
        onProgressChanged: (controller, progress) {
          setState(() {
            _progress = progress / 100;
          });
        },
      ),
    );
  }
}
