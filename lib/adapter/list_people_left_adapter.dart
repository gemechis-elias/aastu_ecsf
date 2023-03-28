import 'package:flutter/material.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListPeopleLeftAdapter {
  List? items = <People>[];
  List itemsTile = <ItemTile>[];

  ListPeopleLeftAdapter(this.items, onItemClick) {
    for (var i = 0; i < items!.length; i++) {
      itemsTile
          .add(ItemTile(index: i, object: items![i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
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
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(width: 15),
            Container(
                child: CircleAvatar(
                  backgroundImage: AssetImage(object.image),
                ),
                width: 45,
                height: 45),
            Container(width: 15),
            Expanded(
              child: Text(
                object.name!,
                style: MyText.medium(context).copyWith(color: Colors.grey[800]),
              ),
            ),
            Container(width: 15),
          ],
        ),
      ),
    );
  }
}
