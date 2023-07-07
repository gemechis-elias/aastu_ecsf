import 'dart:developer';
import 'package:aastu_ecsf/route/chat_screen/admin_chats.dart';
import 'package:aastu_ecsf/route/chat_screen/chat_inbox.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListRoute extends StatefulWidget {
  const ChatListRoute({super.key});

  @override
  ChatListRouteState createState() => ChatListRouteState();
}

class ChatListRouteState extends State<ChatListRoute> {
  String receiverId = '';
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('counsel');

  @override
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

  void _handleStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasStartedChat', true);
    setState(() {
      _hasStartedChat = true;
    });
  }

  void _showProtectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1f1f1f),
          title: const Row(
            children: [
              Icon(
                FontAwesome.user_secret,
                color: Colors.grey,
              ),
              SizedBox(width: 10),
              Text(
                'Ghost Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'MyBoldFont',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'MyLightFont',
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'Your conversation is ',
                    ),
                    TextSpan(
                      text: 'end-to-end',
                      style: TextStyle(
                        color: Color(0xffD1a555),
                      ),
                    ),
                    TextSpan(
                      text: ' encrypted and you are in ghost mode.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'MyBoldFont',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    databaseReference.onValue.listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        dynamic value = snapshot.value;
        receiverId = value['active_id'];

        log("Active id $receiverId");
      } else {}
    });

    log('hasStartedChat: $_hasStartedChat');
    this.context = context;

    return Scaffold(
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
          actions: [
            IconButton(
              icon: const Icon(FontAwesome.user_secret),
              onPressed: _showProtectionDialog,
            ),
          ],
        ),
        body: Container(
          color: const Color(0xff1f1f1f),
          child: _hasStartedChat
              ? receiverId == FirebaseAuth.instance.currentUser!.uid
                  ? ChatListPage(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                    )
                  : chatListView()
              : DefualtView(),
        ));
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
                  style: TextStyle(fontFamily: 'MyFont', color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatListView() {
    return InkWell(
      onTap: () {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        log("Current User ID: $userId");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatTelegramRoute(
              user_id: userId!,
              receiver_id: receiverId,
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
                    "Start a chat with us",
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
