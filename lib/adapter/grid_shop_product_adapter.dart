import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/shop_product.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/widget/star_rating.dart';

class GridShopProductAdapter {
  List items = <ShopProduct>[];
  List itemsTile = <ItemTile>[];

  GridShopProductAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      childAspectRatio: 0.8,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      padding: EdgeInsets.all(4),
      crossAxisCount: 2,
      children: itemsTile as List<Widget>,
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final ShopProduct object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(ShopProduct obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Container(
        padding: EdgeInsets.all(2),
        child: Card(
            margin: EdgeInsets.all(0),
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(Img.get(object.image),
                      width: double.infinity, fit: BoxFit.cover),
                ),
                Container(height: 5),
                Row(
                  children: <Widget>[
                    Container(width: 10),
                    Expanded(
                      child: Text(object.title,
                          style: MyText.subhead(context)!
                              .copyWith(color: MyColors.grey_90),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Container(width: 5),
                    Icon(Icons.more_vert, color: MyColors.grey_40, size: 20),
                  ],
                ),
                Container(height: 5),
                Row(
                  children: <Widget>[
                    Container(width: 10),
                    StarRating(
                        starCount: 5,
                        rating: 4.5,
                        color: Colors.yellow,
                        size: 14),
                    Spacer(),
                    Text(object.price,
                        style: MyText.subhead(context)!.copyWith(
                            color: MyColors.primary,
                            fontWeight: FontWeight.bold)),
                    Container(width: 10),
                  ],
                ),
                Container(height: 10),
              ],
            )),
      ),
    );
  }
}
