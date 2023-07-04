import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/model/message.dart';

class ChatTelegramAdapter {
  List items = <Message>[];
  BuildContext context;
  Function onItemClick;
  ScrollController scrollController = ScrollController();

  ChatTelegramAdapter(this.context, this.items, this.onItemClick);

  void insertSingleItem(Message msg) {
    int insertIndex = items.length;
    items.insert(insertIndex, msg);
    scrollController.animateTo(scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  Widget getView() {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: scrollController,
      itemBuilder: (context, index) {
        Message item = items[index];
        return buildListItemView(index, item);
      },
    );
  }

  Widget buildListItemView(int index, Message item) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    bool isMe = true ? item.sender == userId : false;
    // Define a regular expression for matching hashtags and usernames
    final hashtagRegex = RegExp(r'\B#\w+');
    final usernameRegex = RegExp(r'\B@\w+');

// Define a function that returns a text span for the given text and style
    TextSpan getStyledText(String text, TextStyle style) {
      return TextSpan(
        text: text,
        style: style,
      );
    }

// Define a function that returns a list of text spans for the given text
    List<TextSpan> getStyledTextSpans(String text) {
      final List<TextSpan> textSpans = [];

      // Split the text into words
      final words = text.split(' ');

      // Loop through each word and check if it matches a pattern
      for (final word in words) {
        if (hashtagRegex.hasMatch(word)) {
          // If the word matches the hashtag pattern, add a blue colored text span
          textSpans.add(getStyledText(
              word,
              const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 11, 58, 97))));
        } else if (usernameRegex.hasMatch(word)) {
          // If the word matches the username pattern, add a blue colored text span
          textSpans.add(getStyledText(
              word,
              const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 14, 58, 94))));
        } else if (Uri.parse(word).isAbsolute) {
          // If the word is a valid URL, add a blue colored text span
          textSpans.add(getStyledText(
              word,
              const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 16, 63, 102))));
        } else {
          // Otherwise, add the text without any styling
          textSpans.add(getStyledText(
              word, const TextStyle(fontSize: 16, color: Colors.black)));
        }
        // Add a space after each word
        textSpans.add(getStyledText(' ', const TextStyle(color: Colors.black)));
      }

      return textSpans;
    }

    return Wrap(
      alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
      children: <Widget>[
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.fromLTRB(isMe ? 20 : 10, 5, isMe ? 10 : 20, 5),
            color: isMe
                ? const Color.fromARGB(255, 193, 206, 180)
                : const Color.fromARGB(255, 230, 212, 173),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    constraints: const BoxConstraints(minWidth: 150),
                    child: RichText(
                      text: TextSpan(
                        children: getStyledTextSpans(item.content),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3, width: 0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(item.date,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 12,
                              color: isMe
                                  ? const Color(0xff58B346)
                                  : const Color.fromARGB(255, 49, 47, 56))),
                      Container(width: 3),
                      isMe
                          ? const Icon(Icons.done_all,
                              size: 12, color: Color(0xff58B346))
                          : Container(width: 0, height: 0)
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  int getItemCount() => items.length;
}
