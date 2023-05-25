import 'dart:async';

import 'package:aastu_ecsf/model/event.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/chat_screen/chat_telegram_adapter.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/message.dart';
import 'package:aastu_ecsf/utils/tools.dart';
import 'package:aastu_ecsf/widget/circle_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ChatTelegramRoute extends StatefulWidget {
  final String user_id, admin_id;
  const ChatTelegramRoute({required this.user_id, required this.admin_id});

  @override
  ChatTelegramRouteState createState() => ChatTelegramRouteState();
}

class ChatTelegramRouteState extends State<ChatTelegramRoute> {
  late DatabaseReference _messagesRef;
  StreamSubscription<Event>? _messagesSubscription;

  bool showSend = false;
  final TextEditingController inputController = TextEditingController();
  List<Message> items = [];
  late ChatTelegramAdapter adapter;

  @override
  void initState() {
    super.initState();
    items.add(Message.time(
        "ID",
        "This System is developed for you to share your burden with us & for us to be one step closer to you in what you need. If you have anything to share to us, so that we could #listen and #counsel you, we would be more than happy to be there for you and remind you the love that GOD has for you.",
        false,
        items.length % 5 == 0,
        Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
    items.add(Message.time("ID", "Hello!", true, items.length % 5 == 0,
        Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));

    _messagesRef = FirebaseDatabase.instance
        .ref()
        .child('chats')
        .child(widget.user_id)
        .child(widget.admin_id);

// Start listening for new messages
    _messagesSubscription = _messagesRef.onChildAdded.listen((event) {
      // Retrieve the message data from the event
      var messageData = event.snapshot.value as Map<String, dynamic>?;

      if (messageData != null) {
        // Create a Message object from the data
        Message message = Message(
          messageData['id'],
          messageData['content'],
          messageData['fromMe'],
          messageData['date'],
        );

        // Add the message to the list
        setState(() {
          items.add(message);
        });
      }
    }) as StreamSubscription<Event>?;
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    adapter = ChatTelegramAdapter(context, items, onItemClick);

    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
          backgroundColor: const Color(0xff121212),
          brightness: Brightness.dark,
          title: Row(
            children: <Widget>[
              CircleImage(
                imageProvider: AssetImage(Img.get('photo_female_4.jpg')),
                size: 40,
              ),
              Container(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Counseling Bot",
                      style:
                          MyText.medium(context).copyWith(color: Colors.white)),
                  Container(height: 2),
                  Text("Online",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_10)),
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
                  value: "Settings",
                  child: Text("Settings"),
                ),
              ],
            )
          ]),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: adapter.getView(),
            ),
            Container(
              color: const Color.fromARGB(255, 48, 48, 48),
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.sentiment_satisfied,
                          color: Color.fromARGB(255, 209, 209, 209)),
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 158, 158, 158),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 235, 235,
                            235), // Change the text color to blue
                      ),
                      onChanged: (term) {
                        setState(() {
                          showSend = (term.isNotEmpty);
                        });
                      },
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.attach_file,
                          color: Color.fromARGB(255, 182, 182, 182)),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(showSend ? Icons.send : Icons.mic,
                          color: Colors.blue),
                      onPressed: () {
                        if (showSend) sendMessage();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onItemClick(int index, String obj) {}

  void sendMessage() {
    String message = inputController.text;
    inputController.clear();
    showSend = false;

    // Generate a unique ID for the new message
    String messageId = _messagesRef.push().key!;

    // Create a message object
    Message newMessage = Message.time(
      messageId,
      message,
      true,
      items.length % 5 == 0,
      Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch),
    );

    // Save the message to the database
    _messagesRef.child(messageId).set(newMessage.toJson());

    setState(() {
      // Add the new message to the list
      items.add(newMessage);
    });

    generateReply(message);
  }

  void generateReply(String msg) {
    Timer(const Duration(seconds: 1), () {
      // Generate a unique ID for the reply message
      String replyId = _messagesRef.push().key!;

      // Create a reply message object
      Message replyMessage = Message.time(
        replyId,
        msg,
        false,
        items.length % 5 == 0,
        Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch),
      );

      // Save the reply message to the database
      _messagesRef.child(replyId).set(replyMessage.toJson());

      setState(() {
        // Add the reply message to the list
        items.add(replyMessage);
      });
    });
  }
}
