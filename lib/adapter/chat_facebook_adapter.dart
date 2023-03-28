import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/message.dart';
import 'package:aastu_ecsf/widget/circle_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ChatFacebookAdapter {
  List items = <Message>[];
  BuildContext context;
  Function onItemClick;
  ScrollController scrollController = new ScrollController();

  ChatFacebookAdapter(this.context, this.items, this.onItemClick);

  void insertSingleItem(Message msg) {
    int insertIndex = items.length;
    items.insert(insertIndex, msg);
    scrollController.animateTo(scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  Widget getView() {
    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.symmetric(vertical: 10),
      controller: scrollController,
      itemBuilder: (context, index) {
        Message item = items[index];
        return buildListItemView(index, item);
      },
    );
  }

  Widget buildListItemView(int index, Message item) {
    bool isMe = item.fromMe;
    return Column(
      children: <Widget>[
        item.showTime
            ? Container(
                padding: EdgeInsets.all(5),
                child: Text(item.date,
                    style: TextStyle(fontSize: 12, color: MyColors.grey_40)),
              )
            : Container(width: 0, height: 0),
        Row(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Container(width: isMe ? 20 : 10, height: 0),
            isMe
                ? Container(width: 0, height: 0)
                : Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircleImage(
                      imageProvider: AssetImage(Img.get('photo_female_1.jpg')),
                    ),
                  ),
            Container(width: isMe ? 0 : 5),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.fromLTRB(
                          isMe ? 20 : 0, 5, isMe ? 0 : 20, 5),
                      color: isMe ? Color(0xff0382FE) : MyColors.grey_10,
                      elevation: 0,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text(item.content,
                            style: MyText.subhead(context)!.copyWith(
                                color: isMe ? Colors.white : MyColors.grey_90)),
                      ))
                ],
              ),
            ),
            (index == items.length - 1 && isMe)
                ? Container(
                    padding: EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.check_circle,
                          size: 10, color: Color(0xff0382FE)),
                    ),
                  )
                : Container(width: 10, height: 10),
            Container(width: isMe ? 10 : 20, height: 0)
          ],
        )
      ],
    );
  }

  int getItemCount() => items.length;
}
