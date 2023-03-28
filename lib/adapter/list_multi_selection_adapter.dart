import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/model/inbox.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListMultiSelectionAdapter {
  late BuildContext context;
  List<Inbox> items = [];
  List<Widget> itemsTile = [];
  bool modeSelection = false;
  int selectedCount = 0;
  late Function onSelected;

  ListMultiSelectionAdapter(this.context, this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(itemTile(i, items[i], onItemClick));
    }
  }

  void setOnSelectedMode(Function onSelected) {
    this.onSelected = onSelected;
  }

  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
      ),
    );
  }

  void checkSelected() {
    selectedCount = 0;
    bool anySelected = false;
    for (Inbox i in items) {
      if (i.selected.value) {
        anySelected = true;
        selectedCount++;
      }
    }
    modeSelection = anySelected;
  }

  void clearSelection() {
    items.forEach((e) {
      e.selected.value = false;
    });
    modeSelection = false;
    this.onSelected(modeSelection, selectedCount);
  }

  Widget itemTile(int index, Inbox object, Function onItemClickListener) {
    return Obx(() => InkWell(
          onTap: () {
            if (modeSelection) {
              object.selected.value = !object.selected.value;
              checkSelected();
              this.onSelected(modeSelection, selectedCount);
            } else {
              onItemClickListener(index, object);
            }
          },
          onLongPress: () {
            object.selected.value = true;
            checkSelected();
            this.onSelected(modeSelection, selectedCount);
          },
          child: Column(
            children: [
              Container(
                color: object.selected.value
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    object.selected.value
                        ? Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[600],
                                shape: BoxShape.circle),
                            child: Icon(Icons.check, color: Colors.white),
                          )
                        : Container(
                            child: CircleAvatar(
                                backgroundImage: AssetImage(object.image)),
                            width: 40,
                            height: 40),
                    Container(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(object.name!,
                                  style: MyText.medium(context).copyWith(
                                      color: MyColors.grey_90,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Text(object.date!,
                                  style: MyText.body1(context)!.copyWith(
                                      color: Colors.blue[300],
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(height: 3),
                          Text(object.email!,
                              style: MyText.body1(context)!.copyWith(
                                  color: MyColors.grey_90,
                                  fontWeight: FontWeight.bold)),
                          Container(height: 3),
                          Text(
                            MyStrings.middle_lorem_ipsum,
                            maxLines: 1,
                            style: MyText.body1(context)!
                                .copyWith(color: MyColors.grey_40),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[400], height: 1),
            ],
          ),
        ));
  }
}
