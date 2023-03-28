import 'package:flutter/material.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class GridCallerAdapter {
  List<People> items = [];
  List<ItemTile> itemsTile = [];

  GridCallerAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      padding: EdgeInsets.all(4),
      crossAxisCount: 2,
      children: itemsTile,
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
    return Stack(
      children: <Widget>[
        Image.asset(
          object.image,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.7),
                  ])),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            alignment: Alignment.centerLeft,
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(object.name!,
                        style: MyText.subhead(context)!
                            .copyWith(color: Colors.white)),
                    Container(width: 5),
                    Icon(Icons.star, color: Colors.white, size: 15)
                  ],
                ),
                Text("Mobile",
                    style:
                        MyText.caption(context)!.copyWith(color: Colors.white)),
              ],
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
              highlightColor: Colors.black.withOpacity(0.1),
              splashColor: Colors.black.withOpacity(0.1),
              onTap: () {
                onItemClick(object);
              },
              child:
                  Container(height: double.infinity, width: double.infinity)),
        ),
      ],
    );
  }
}
