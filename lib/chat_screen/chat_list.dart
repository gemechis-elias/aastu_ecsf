import 'dart:developer';

import 'package:aastu_ecsf/chat_screen/chat_inbox.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/user_provider.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/chat_screen/chat_list_adapter.dart';
import 'package:aastu_ecsf/data/dummy.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/toolbar.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_page.dart';

class ChatListRoute extends StatefulWidget {
  ChatListRoute();

  @override
  ChatListRouteState createState() => new ChatListRouteState();
}

class ChatListRouteState extends State<ChatListRoute> {
  late BuildContext context;
  bool _hasStartedChat = false;
  void onItemClick(int index, People obj) {
    MyToast.show(obj.name!, context, duration: MyToast.LENGTH_SHORT);
  }

  @override
  void initState() {
    super.initState();
    _loadHasStartedChat(); // load the saved value on app start
  }

  void _loadHasStartedChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasStartedChat = prefs.getBool('hasStartedChat') ?? false;
    setState(() {
      _hasStartedChat = hasStartedChat;
    });
    log('hasStartedChat: $_hasStartedChat');
  }

  void _handleDelete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasStartedChat', false);
    setState(() {
      _hasStartedChat = false;
    });
  }

  void _handleStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasStartedChat', true);
    setState(() {
      _hasStartedChat = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('hasStartedChat: $_hasStartedChat');
    this.context = context;
    List<People> items = Dummy.getPeopleData();
    items.addAll(Dummy.getPeopleData());
    items.addAll(Dummy.getPeopleData());

    int sectCount = 0;
    int sectIdx = 0;
    List<String> months = Dummy.getStringsMonth();
    for (int i = 0; i < items.length / 6; i++) {
      items.insert(sectCount, People.section(months[sectIdx], true));
      sectCount = sectCount + 5;
      sectIdx++;
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
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
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _handleDelete,
            ),
          ],
        ),
        body: Container(
            color: const Color(0xff1f1f1f),
            child: _hasStartedChat ? ChatListView() : DefualtView()));
  }

  // ignore: non_constant_identifier_names
  Widget DefualtView() {
    return Align(
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
                    Container(height: 10, width: 145, color: Colors.grey[300]),
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
                    Container(height: 10, width: 100, color: Colors.grey[200]),
                    Container(height: 10),
                    Container(height: 10, width: 145, color: Colors.grey[200]),
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
                onPressed: _handleStart,
                child: const Text(
                  "Start Chat",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ChatListView() {
    return InkWell(
      onTap: () {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final userId = userProvider.userId;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatTelegramRoute(
              user_id: userId ?? "",
              admin_id: 'Lg7zRXidF9aArTPo01MrwFTcqiL2',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(width: 18),
            const SizedBox(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.jpg"),
                ),
                width: 50,
                height: 50),
            Container(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Chat Service",
                    style: MyText.medium(context).copyWith(
                        color: Colors.grey[300], fontWeight: FontWeight.normal),
                  ),
                  Container(height: 5),
                  Text(
                    "Hi, How are you?",
                    maxLines: 2,
                    style:
                        MyText.subhead(context)!.copyWith(color: Colors.grey),
                  ),
                  Container(height: 15),
                  const Divider(color: Color(0xff808080), height: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
