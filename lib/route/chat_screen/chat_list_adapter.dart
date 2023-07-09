import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListSectionedAdapter {
  List items = <People>[];
  List itemsTile = <ItemTile>[];
  late Function onItemClick;

  ListSectionedAdapter(this.items, this.onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  void addItem(People item) {
    items.insert(1, item);
    itemsTile.insert(1, ItemTile(index: 1, object: item, onClick: onItemClick));
  }

  Widget getView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => itemsTile[index],
      itemCount: itemsTile.length,
      padding: const EdgeInsets.symmetric(vertical: 5),
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final People object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(People obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    if (object.section) {
      // for section view
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        child: Text(object.name!,
            style: MyText.subhead(context)!.copyWith(
                fontFamily: "MyFont",
                color: Colors.grey,
                fontWeight: FontWeight.w500)),
      );
    } else {
      // for people vew
      return InkWell(
        onTap: () {
          onItemClick(object);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(width: 18),
              SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(object.image),
                  )),
              Container(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      object.name!,
                      style: MyText.medium(context).copyWith(
                          fontFamily: "MyFont",
                          color: Colors.grey[800],
                          fontWeight: FontWeight.normal),
                    ),
                    Container(height: 5),
                    Text(
                      MyStrings.middle_lorem_ipsum,
                      maxLines: 2,
                      style: MyText.subhead(context)!
                          .copyWith(fontFamily: "MyFont", color: Colors.grey),
                    ),
                    Container(height: 15),
                    Divider(color: Colors.grey[300], height: 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
