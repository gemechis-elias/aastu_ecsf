import 'package:flutter/material.dart';

class GridBasicAdapter {
  List items = <String>[];
  List itemsTile = <ItemTile>[];

  GridBasicAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      padding: EdgeInsets.all(2),
      crossAxisCount: 3,
      children: itemsTile as List<Widget>,
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final String object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  })  : super(key: key);

  void onItemClick(String obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          object,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
              highlightColor: Colors.black.withOpacity(0.1),
              splashColor: Colors.black.withOpacity(0.1),
              onTap: () {
                onItemClick(object);
              },
              child: Container(
                  height: double.infinity,
                  width: double.infinity
              )
          ),
        ),
      ],
    );
  }
}
