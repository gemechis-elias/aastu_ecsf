import 'dart:async';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/circle_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/route/chat_screen/chat_message_adapter.dart';
import 'package:aastu_ecsf/model/message.dart';
import 'package:aastu_ecsf/utils/tools.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatInboxRoute extends StatefulWidget {
  final String user_id, receiver_id;
  const ChatInboxRoute({
    Key? key,
    required this.user_id,
    required this.receiver_id,
  }) : super(key: key);

  @override
  ChatInboxRouteState createState() => ChatInboxRouteState();
}

class ChatInboxRouteState extends State<ChatInboxRoute> {
  late DatabaseReference _userMessagesRef;
  late DatabaseReference _receiverMessagesRef;
  late StreamSubscription<DatabaseEvent> _userMessagesSubscription;
  late StreamSubscription<DatabaseEvent> _receiverMessagesSubscription;

  bool isKeyboardVisible = false;
  bool showSend = false;
  final TextEditingController inputController = TextEditingController();
  List<Message> items = [];
  late ChatTelegramAdapter adapter;

  Future<List<Message>> fetchUserMessages() async {
    DataSnapshot dataSnapshot = await _userMessagesRef.get();
    List<Message> userMessages = [];
    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> userMessagesData =
          dataSnapshot.value as Map<dynamic, dynamic>;
      userMessagesData.forEach((key, value) {
        var messageData = value as Map<dynamic, dynamic>?;

        if (messageData != null) {
          Message message = Message(
            messageData['id'],
            messageData['content'],
            messageData['date'],
            messageData['sender'],
            messageData['receiver'],
          );

          if (message.sender == widget.user_id &&
              message.receiver == widget.receiver_id) {
            userMessages.add(message);
          }
        }
      });
    }
    return userMessages;
  }

  Future<List<Message>> fetchReceiverMessages() async {
    DataSnapshot dataSnapshot = await _receiverMessagesRef.get();
    List<Message> receiverMessages = [];
    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> receiverMessagesData =
          dataSnapshot.value as Map<dynamic, dynamic>;
      receiverMessagesData.forEach((key, value) {
        var messageData = value as Map<dynamic, dynamic>?;

        if (messageData != null) {
          Message message = Message(
            messageData['id'],
            messageData['content'],
            messageData['date'],
            messageData['sender'],
            messageData['receiver'],
          );

          if (message.sender == widget.receiver_id &&
              message.receiver == widget.user_id) {
            receiverMessages.add(message);
          }
        }
      });
    }
    return receiverMessages;
  }

  @override
  void initState() {
    super.initState();
    _userMessagesRef = FirebaseDatabase.instance.ref().child('chats');
    _receiverMessagesRef = FirebaseDatabase.instance.ref().child('chats');

    _userMessagesSubscription = _userMessagesRef.onChildAdded.listen((event) {
      // Handle new user message
      setState(() {
        // Update items list
        // ...
      });
    });

    _receiverMessagesSubscription =
        _receiverMessagesRef.onChildAdded.listen((event) {
      // Handle new receiver message
      setState(() {
        // Update items list
        // ...
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userMessagesSubscription.cancel();
    _receiverMessagesSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    Future<List<Message>> AllFetchedMEssages() async {
      List<Message> userMessages = await fetchUserMessages();
      List<Message> receiverMessages = await fetchReceiverMessages();

      // Combine user and receiver messages into a single list
      List<Message> allMessages = [...userMessages, ...receiverMessages];
      allMessages.sort((a, b) => a.date.compareTo(b.date));

      return allMessages;
    }

    return FutureBuilder<List<Message>>(
      future: AllFetchedMEssages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return const SizedBox(
            width: 24, // Adjust the size as needed
            height: 24, // Adjust the size as needed
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Message> userMessages = snapshot.data!;
          List<Message> receiverMessages = snapshot.data!;

          // Combine user and receiver messages into a single list
          List<Message> allMessages = [...userMessages, ...receiverMessages];
          allMessages.sort((a, b) => a.date.compareTo(b.date));

          adapter = ChatTelegramAdapter(context, allMessages, onItemClick);

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
                        "Counseling Bot",
                        style: MyText.medium(context).copyWith(
                            fontFamily: "MyFont",
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(height: 2),
                      Text(
                        "bot",
                        style: MyText.caption(context)!.copyWith(
                            fontFamily: "MyFont",
                            fontSize: 13,
                            color: const Color.fromARGB(255, 177, 177, 177)),
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
                      value: "Settings",
                      child: Text("Settings"),
                    ),
                  ],
                )
              ],
            ),
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
                          icon: const Icon(
                            FontAwesomeIcons.keyboard,
                            color: Color.fromARGB(255, 209, 209, 209),
                          ),
                          onPressed: () {
                            setState(() {
                              if (isKeyboardVisible) {
                                // Close the keyboard if it is already open
                                FocusScope.of(context).unfocus();
                              } else {
                                // Open the keyboard if it is closed
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                              isKeyboardVisible = !isKeyboardVisible;
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: inputController,
                            maxLines: 1,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Message',
                              hintStyle: TextStyle(
                                fontFamily: "MyFont",
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
                          onPressed: () {
                            MyToast.show(
                                "File Attachment not supported for now",
                                context);
                          },
                        ),
                        IconButton(
                          icon: Icon(showSend ? Icons.send : Icons.send,
                              color: showSend ? Colors.blue : MyColors.grey_60),
                          onPressed: () {
                            if (showSend) sendMessage();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void onItemClick(int index, String obj) {}

  void sendMessage() {
    String message = inputController.text;
    inputController.clear();
    showSend = false;

    String messageId = _userMessagesRef.push().key!;

    Message newMessage = Message(
      messageId,
      message,
      Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch),
      widget.user_id,
      widget.receiver_id,
    );

    // Store the message in the "chats" node
    _userMessagesRef.child(messageId).set(newMessage.toJson());

    // Add the message ID to the "ChatList" node for both sender and receiver
    FirebaseDatabase.instance
        .ref()
        .child('ChatList')
        .child(widget.user_id)
        .child(messageId)
        .set(true);
    FirebaseDatabase.instance
        .ref()
        .child('ChatList')
        .child(widget.receiver_id)
        .child(messageId)
        .set(false);

    setState(() {
      items.add(newMessage);
    });
  }
}
