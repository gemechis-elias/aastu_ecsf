import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/news.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListNewsCardAdapter {
  List items = <News>[];
  List itemsTile = <ItemTile>[];

  ListNewsCardAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  SliverList getView() {
    return SliverList(
        delegate: SliverChildListDelegate(itemsTile as List<Widget>));
  }

  Widget getWidgetView({EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    return ListView.builder(
      padding: padding,
      itemBuilder: (BuildContext context, int index) => itemsTile[index],
      itemCount: itemsTile.length,
    );
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
        child: Card(
            margin: EdgeInsets.all(0),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: <Widget>[
                Image.asset(Img.get(object.image),
                    height: 150, width: double.infinity, fit: BoxFit.cover),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
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
                                color: MyColors.grey_80,
                                fontWeight: FontWeight.w500)),
                        Container(height: 10),
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
