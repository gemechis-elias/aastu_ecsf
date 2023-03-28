import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/model/shop_category.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListCategoryImageAdapter {
  List items = <ShopCategory>[];
  List itemsTile = <ItemTile>[];

  ListCategoryImageAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final ShopCategory object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(ShopCategory obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Container(
        height: 180,
        child: Stack(
          children: <Widget>[
            Image.asset(Img.get(object.image),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover),
            Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(object.title,
                        style: MyText.title(context)!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                    Container(height: 10),
                    Container(
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.1),
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side:
                                    BorderSide(color: Colors.white, width: 2))),
                        child: Text(
                          object.brief,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
