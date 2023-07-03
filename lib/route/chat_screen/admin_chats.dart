import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/route/chat_screen/chat_inbox.dart';
import 'package:aastu_ecsf/model/chatItems.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatListPage extends StatefulWidget {
  final String userId;

  ChatListPage({required this.userId});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late DatabaseReference _userMessagesRef;
  late StreamSubscription<DatabaseEvent> _userMessagesSubscription;
  List<ChatItem> chatItems = [];

  @override
  void initState() {
    super.initState();
    log("Chat List Page, Loading...");

    _userMessagesRef = FirebaseDatabase.instance.ref().child('ChatList');

    _userMessagesSubscription = _userMessagesRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> chatListData =
            event.snapshot.value as Map<dynamic, dynamic>;

        List<String> chatIds = chatListData.keys.cast<String>().toList();
        log("Chat List Page, Chat IDs: $chatIds");
        // Clear the chatItems list before fetching and updating chat details
        chatItems.clear();
        // Fetch chat details from the "users" database and update the chatItems list
        fetchChatDetails(chatIds);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userMessagesSubscription.cancel();
  }

  void fetchChatDetails(List<String> chatIds) {
    // Fetch chat details for each chat ID
    for (String chatId in chatIds) {
      FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(chatId)
          .onValue
          .listen((event) {
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> userData =
              event.snapshot.value as Map<dynamic, dynamic>;

          String userName = userData['name'];
          String email = "Start a conversation";

          setState(() {
            if (chatId != widget.userId) {
              chatItems.add(ChatItem(chatId, userName, email));
            }
          });
        }
      });
    }
  }

  void openChat(String userId, String receiverId) {
    // Open the chat page and pass the user ID and receiver ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatTelegramRoute(
          user_id: userId,
          receiver_id: receiverId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          ChatItem chatItem = chatItems[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            title: Text(chatItem.userName),
            subtitle: Text(chatItem.lastMessage),
            onTap: () {
              openChat(widget.userId, chatItem.userId);
            },
          );
        },
      ),
    );
  }
}
