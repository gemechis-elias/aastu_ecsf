import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/menu.dart';

class MenuAdapter {
  List items = <Menu>[];
  List itemsTile = <MenuTile>[];

  MenuAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(MenuTile(index: i, object: items[i], onClick: onItemClick));
    }
  }
}

// ignore: must_be_immutable
class MenuTile extends StatelessWidget {
  final Menu object;
  final int index;
  final Function onClick;

  const MenuTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(Menu obj) {
    obj.expand = !obj.expand;
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext ctx) {
    if (object.type == "DIVIDER") {
      return Divider(thickness: 0.2, color: Colors.grey[500]);
    }
    if (object.type == "SPACER") {
      return Container(height: 50);
    }
    return Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            getContainerClickable(
                getItemView(ctx, object), object, onItemClick),
            object.expand
                ? Column(
                    children: getSubItemViews(ctx, object.subs as List<Menu>),
                  )
                : Container(),
          ],
        ));
  }

  Widget getContainerClickable(Widget widget, Menu obj, Function func) {
    bool sub = obj.subs.isEmpty;
    return Container(
      height: sub ? 38 : 45,
      child: InkWell(
        highlightColor: Colors.grey,
        splashColor: Colors.grey,
        onTap: () => func(obj),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10), child: widget),
      ),
    );
  }

  Widget getItemView(BuildContext ctx, Menu obj) {
    bool sub = obj.subs.isEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          sub
              ? Container(width: 40)
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    obj.icon,
                    size: 20.0,
                    color: Colors.blue,
                  ),
                ),
          Center(
            child: Text(obj.title,
                style: TextStyle(
                    color: Colors.grey[100],
                    fontWeight: FontWeight.normal,
                    fontSize: 15)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 4, 10, 0),
            height: 6,
            width: 6,
            child: CircleAvatar(
                backgroundColor: obj.newPage
                    ? MyColors.accentDark.withOpacity(0.6)
                    : Colors.transparent),
          ),
          Spacer(),
          sub
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    obj.expand ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    size: 24.0,
                    color: Colors.blue,
                  ),
                ),
        ],
      ),
    );
  }

  List<Widget> getSubItemViews(BuildContext ctx, List<Menu> subs) {
    List widgets = <Widget>[];
    for (Menu m in subs) {
      widgets.add(getContainerClickable(getItemView(ctx, m), m, onItemClick));
    }
    return widgets as List<Widget>;
  }
}
