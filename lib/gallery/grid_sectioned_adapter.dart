import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/section_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class GridSectionedAdapter {
  List<SectionImage> items = <SectionImage>[];
  List<ItemTile> itemsTile = <ItemTile>[];

  GridSectionedAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(5),
      crossAxisCount: 3,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => itemsTile[index],
      staggeredTileBuilder: (int index) => new StaggeredTile.count(
          items[index].section ? 3 : 1, items[index].section ? 0.4 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final SectionImage object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(SectionImage obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return object.section
        ? Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Text(object.title,
                style: MyText.subhead(context)!.copyWith(
                    color: MyColors.grey_40, fontWeight: FontWeight.bold)),
          )
        : Stack(
            children: <Widget>[
              Image.asset(
                object.image,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
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
          );
  }
}
