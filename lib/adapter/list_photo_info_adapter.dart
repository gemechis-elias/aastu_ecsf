import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/photo_info.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListPhotoInfoAdapter {
  List<PhotoInfo> items = <PhotoInfo>[];
  List<PhotoInfo> itemsOriginal = <PhotoInfo>[];
  List itemsTile = <ItemTile>[];
  List itemsTileOriginal = <ItemTile>[];
  late Function onClick;
  var update = false.obs;

  ListPhotoInfoAdapter(this.items, onItemClick) {
    itemsOriginal = this.items;
    this.onClick = onItemClick;
    buildListTile();
    itemsTileOriginal = itemsTile;
  }

  void buildListTile() {
    itemsTile = [];
    for (var i = 0; i < items.length; i++) {
      itemsTile
          .add(ItemTile(index: i, object: items[i], onClick: this.onClick));
    }
  }

  Widget getView() {
    return Obx(() {
      update.value;
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
        padding: EdgeInsets.symmetric(vertical: 10),
      );
    });
  }

  void filter(String keyword) {
    String s = keyword.trim().toLowerCase();
    if (s.isEmpty) {
      items = itemsOriginal;
      itemsTile = itemsTileOriginal;
    } else {
      items = itemsOriginal
          .where((PhotoInfo e) => e.title!.toLowerCase().contains(s))
          .toList();
      buildListTile();
    }
    update.value = !update.value;
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final PhotoInfo object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(PhotoInfo obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(width: 15),
            Container(child: Icon(object.icon, color: MyColors.grey_60)),
            Container(width: 20),
            Expanded(
              child: Text(
                object.title!,
                style: MyText.subhead(context)!.copyWith(
                    color: MyColors.grey_60, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
