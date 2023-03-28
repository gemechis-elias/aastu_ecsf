import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/message.dart';
import 'package:aastu_ecsf/widget/circle_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ChatBBMAdapter {
  List items = <Message>[];
  BuildContext context;
  Function onItemClick;
  ScrollController scrollController = new ScrollController();

  ChatBBMAdapter(this.context, this.items, this.onItemClick);

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
    return Row(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        isMe ? Spacer(flex: 2) : Container(width: 10, height: 0),
        isMe
            ? Container(width: 0, height: 0)
            : Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: CircleImage(
                  imageProvider: AssetImage(Img.get('photo_male_8.jpg')),
                ),
              ),
        Container(width: isMe ? 0 : 5),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.date,
                  style: TextStyle(fontSize: 10, color: MyColors.grey_20)),
              Container(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin:
                        EdgeInsets.fromLTRB(isMe ? 20 : 0, 0, isMe ? 0 : 20, 5),
                    color: isMe ? Color(0xff5EA1D5) : MyColors.grey_10,
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(4, 5, 4, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          isMe
                              ? Container(
                                  width: 12,
                                  height: 12,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(5, 3, 5, 5),
                                  decoration: BoxDecoration(
                                      color: Color(0xff769738),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Text("R",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic)),
                                )
                              : Container(
                                  width: 7,
                                  height: 7,
                                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      color: MyColors.grey_20,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                          Expanded(
                            child: Text(item.content,
                                style: MyText.subhead(context)!.copyWith(
                                    color: isMe
                                        ? Colors.white
                                        : MyColors.grey_90)),
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
        isMe ? Container(width: 10, height: 0) : Spacer(flex: 2),
      ],
    );
  }

  int getItemCount() => items.length;
}
