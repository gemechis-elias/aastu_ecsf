import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/model/image_obj.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class GridTwoLineAdapter {
  List items = <ImageObj>[];
  List itemsTile = <ItemTile>[];

  GridTwoLineAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      childAspectRatio: 0.8,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      padding: EdgeInsets.all(3),
      crossAxisCount: 2,
      children: itemsTile as List<Widget>,
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final ImageObj object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(ImageObj obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Image.asset(Img.get(object.image), fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            color: Colors.blueGrey[800],
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(object.name,
                          style: MyText.subhead(context)!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Container(height: 2),
                      Text(object.brief,
                          style: MyText.caption(context)!
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                Icon(Icons.star_border, color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}
