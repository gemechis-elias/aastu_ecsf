import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/notif.dart';
import 'package:aastu_ecsf/utils/tools.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class NotificationAdapter {
  List items = <Notif>[];
  List itemsTile = <ItemTile>[];

  NotificationAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
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
  final Notif object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(Notif obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.black.withOpacity(0.5),
      hoverColor: Colors.black.withOpacity(0.5),
      onTap: () {
        onItemClick(object);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Text(
                      object.title!,
                      maxLines: 1,
                      style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: object.isRead
                            ? Colors.transparent
                            : MyColors.accentDark,
                        borderRadius: BorderRadius.circular(15.0))),
                Spacer(),
                Text(
                  Tools.getFormattedDateShort(object.createdAt!),
                  maxLines: 1,
                  style:
                      MyText.body1(context)!.copyWith(color: MyColors.grey_60),
                )
              ],
            ),
            Container(height: 8),
            Row(
              children: <Widget>[
                Flexible(
                  child: new Container(
                    child: Text(
                      object.content!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: MyText.body1(context)!
                          .copyWith(color: MyColors.grey_60),
                    ),
                  ),
                ),
                Container(width: 10),
                object.type == "NORMAL"
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Text(object.type!,
                            style: MyText.caption(context)!.copyWith(
                                color: MyColors.grey_40,
                                fontWeight: FontWeight.w500)),
                      ),
              ],
            ),
            Container(height: 10),
            Divider(
                color: Colors.white.withOpacity(0.1), thickness: 0.3, height: 0)
          ],
        ),
      ),
    );
  }
}
