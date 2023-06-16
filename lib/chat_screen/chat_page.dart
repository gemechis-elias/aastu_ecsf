import 'package:aastu_ecsf/chat_screen/chat_list.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../data/my_strings.dart';

class ChatRoutes extends StatefulWidget {
  ChatRoutes();

  @override
  ChatRoutesState createState() => new ChatRoutesState();
}

class ChatRoutesState extends State<ChatRoutes> {
  bool _hasStartedChat = false;

  @override
  void initState() {
    super.initState();
    _loadHasStartedChat(); // load the saved value on app start
  }

  void _loadHasStartedChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasStartedChat = prefs.getBool('hasStartedChat') ?? false;
    if (mounted) {
      setState(() {
        _hasStartedChat = hasStartedChat;
      });
    }
    print(_hasStartedChat);
  }

  void _saveHasStartedChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasStartedChat', true);
  }

  void _onStartChatPressed() {
    if (_hasStartedChat) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ChatListRoute()));
    } else {
      _saveHasStartedChat();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              ChatListRoute())); // navigate to the chat screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        elevation: 0,
        //  brightness: Brightness.dark,
        backgroundColor: const Color(0xff121212),
        centerTitle: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xffd1a552), Color.fromARGB(255, 209, 150, 82)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Counseling",
            style: TextStyle(
              fontFamily: 'MyBoldFont',
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(height: 20),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                  ),
                  Container(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 10, width: 80, color: Colors.grey[300]),
                      Container(height: 10),
                      Container(
                          height: 10, width: 145, color: Colors.grey[300]),
                      Container(height: 10),
                      Container(height: 10, width: 40, color: Colors.grey[300])
                    ],
                  )
                ],
              ),
              Container(height: 20),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                  ),
                  Container(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 10, width: 100, color: Colors.grey[200]),
                      Container(height: 10),
                      Container(
                          height: 10, width: 145, color: Colors.grey[200]),
                      Container(height: 10),
                      Container(height: 10, width: 40, color: Colors.grey[200])
                    ],
                  )
                ],
              ),
              Container(height: 25),
              const Text(
                'Welcome to the Counseling Team Help Center.',
                style: TextStyle(
                  fontFamily: 'MyBoldFont',
                  color: Color(0xff808080),
                  fontSize: 15,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "You have the option to remain ",
                  style: MyText.subhead(context)!.copyWith(
                    fontFamily: 'MyLightFont',
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: "anonymous",
                      style: MyText.subhead(context)!.copyWith(
                        fontFamily: 'MyLightFont',
                        color: const Color(
                            0xffCA7754), // set the color of the word "anonymous" here
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text:
                          " or secure your chat history. All conversations are protected with End-to-End Encryption.",
                      style: MyText.subhead(context)!.copyWith(
                        fontFamily: 'MyLightFont',
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 25),
              SizedBox(
                width: 180,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD1a554),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _onStartChatPressed,
                  child: const Text(
                    "Start Chat",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 250,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Color(0xff212121),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: MyColors.grey_20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Container(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text:
                            "This System is developed for you to share your burden with us & for us to be one step closer to you in what you need. If you have anything to share to us, so that we could #listen and #counsel you, we would be more than happy to be there for you and remind you the love that GOD has for you. ",
                        style: MyText.subhead(context)!.copyWith(
                          fontFamily: 'MyLightFont',
                          color: Color.fromARGB(174, 255, 255, 255),
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "\nAlways remember this: -",
                            style: MyText.subhead(context)!.copyWith(
                              fontFamily: 'MyLightFont',
                              color: const Color(
                                  0xffCA7754), // set the color of the word "anonymous" here
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text:
                                " his love never depends on the situation you are in, no matter what the situation is, he is always there for you.",
                            style: MyText.subhead(context)!.copyWith(
                              fontFamily: 'MyLightFont',
                              color: Color.fromARGB(174, 255, 255, 255),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffD1a554),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                      child: const Text(
                        "Agree",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        MyToast.show("FOLLOW clicked", context);
                      },
                    ),
                    Container(height: 20),
                  ],
                ),
              ),
              Container(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
