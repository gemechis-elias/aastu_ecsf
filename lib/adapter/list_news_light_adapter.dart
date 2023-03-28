import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/news.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListNewsLightAdapter {
  List items = <News>[];
  List itemsTile = <ItemTile>[];

  ListNewsLightAdapter(this.items, onItemClick) {
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
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          children: <Widget>[
            Card(
                margin: EdgeInsets.all(0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(Img.get(object.image),
                    height: 180, width: double.infinity, fit: BoxFit.cover)),
            Container(height: 10),
            Row(
              children: <Widget>[
                Text(object.subtitle,
                    style: MyText.body2(context)!
                        .copyWith(color: MyColors.grey_40)),
                Spacer(),
                Text(object.date,
                    style: MyText.body1(context)!
                        .copyWith(color: MyColors.grey_40)),
              ],
            ),
            Container(height: 10),
            Text(object.title,
                style: MyText.medium(context).copyWith(
                    color: MyColors.grey_80, fontWeight: FontWeight.w500)),
            Container(height: 10),
            Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
