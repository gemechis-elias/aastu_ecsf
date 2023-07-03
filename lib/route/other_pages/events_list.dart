import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/news.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListNewsImageAdapter {
  List items = <News>[];
  List itemsTile = <ItemTile>[];

  ListNewsImageAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  SliverList getView() {
    return SliverList(
        delegate: SliverChildListDelegate(itemsTile as List<Widget>));
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final News object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(News obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Container(
        height: 230,
        child: Stack(
          children: <Widget>[
            Image.asset(Img.get(object.image),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover),
            Container(
                color: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Text(object.date,
                            style: MyText.body1(context)!
                                .copyWith(color: MyColors.grey_10)),
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(2)),
                          child: Text(object.subtitle,
                              textAlign: TextAlign.start,
                              style: MyText.body1(context)!
                                  .copyWith(color: MyColors.grey_10)),
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Text(object.title,
                        style: MyText.medium(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                    Container(height: 10),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
