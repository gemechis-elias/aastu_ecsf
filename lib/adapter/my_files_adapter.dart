import 'package:flutter/material.dart';
import 'package:aastu_ecsf/model/folder_file.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class MyFilesAdapter {
  List items = <FolderFile>[];
  List itemsTile = <ItemTile>[];

  MyFilesAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
        padding: EdgeInsets.symmetric(vertical: 5),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final FolderFile object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(FolderFile obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (object.section) {
      // for section view
      widget = Padding(
        padding: EdgeInsets.fromLTRB(78, 15, 0, 15),
        child: Text(object.name,
            style: MyText.subhead(context)!
                .copyWith(color: Colors.grey, fontWeight: FontWeight.bold)),
      );
    } else {
      // for FolderFile vew
      widget = InkWell(
        onTap: () {
          onItemClick(object);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(width: 20),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[500],
                child: Icon(object.image, color: Colors.white, size: 20),
              ),
              Container(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      object.name,
                      style: MyText.medium(context).copyWith(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.normal),
                    ),
                    Container(height: 5),
                    Text(
                      object.date,
                      style:
                          MyText.body1(context)!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Icon(Icons.info, color: Colors.grey[300], size: 25),
              Container(width: 20),
            ],
          ),
        ),
      );
    }
    return widget;
  }
}
