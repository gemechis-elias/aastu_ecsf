import 'package:aastu_ecsf/data/TeamImage.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/team_model.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class GridMusicCardAlbum {
  List items = <TeamModel>[];
  List<ItemTile> itemsTile = <ItemTile>[];

  GridMusicCardAlbum(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      childAspectRatio: 0.9,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      padding: EdgeInsets.all(8),
      crossAxisCount: 2,
      children: itemsTile,
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(TeamModel obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Hero(
        tag: index.toString(),
        child: Container(
          padding: EdgeInsets.all(2),
          child: Card(
              color: Color(0xff212121),
              margin: EdgeInsets.all(0),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Image.asset(TeamImage.get(object.image),
                        width: double.infinity, fit: BoxFit.cover),
                  ),
                  Container(height: 5),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(object.name,
                            style: MyText.subhead(context)!.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    const Color.fromARGB(255, 204, 204, 204))),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
