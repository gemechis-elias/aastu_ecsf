import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/model/image_obj.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class GridAlbumAdapter {
  List<ImageObj> items = <ImageObj>[];
  List<ItemTile> itemsTile = <ItemTile>[];

  GridAlbumAdapter(this.items, onItemClick) {
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
    return Hero(
        tag: index.toString(),
        child: Stack(
          children: <Widget>[
            Image.asset(
              Img.get(object.image),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                alignment: Alignment.centerRight,
                height: 50,
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  children: <Widget>[
                    Text(object.name,
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.white)),
                    Spacer(),
                    Text(object.counter.toString(),
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.white)),
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
                  child: Container(
                      height: double.infinity, width: double.infinity)),
            ),
          ],
        ));
  }
}
