import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/music_song.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class ListMusicSongAdapter {
  List items = <MusicSong>[];
  List itemsTile = <ItemTile>[];

  ListMusicSongAdapter(this.items, onItemClick) {
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
  final MusicSong object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(MusicSong obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Image.asset(
                  Img.get(object.image),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                Container(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(object.title,
                          maxLines: 1,
                          style: MyText.subhead(context)!
                              .copyWith(color: MyColors.grey_90)),
                      Container(height: 5),
                      Text(object.brief,
                          maxLines: 1,
                          style: MyText.caption(context)!
                              .copyWith(color: MyColors.grey_40)),
                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: MyColors.grey_40)
              ],
            ),
          ),
          Divider(height: 0)
        ],
      ),
    );
  }
}
