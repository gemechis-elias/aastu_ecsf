import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

class ListSwipeAdapter {
  List? items = <People>[];
  Function onSwipe;

  ListSwipeAdapter(this.items, this.onSwipe);

  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ItemTile(index, items![index], this.onSwipe);
        },
        itemCount: this.items!.length,
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final People object;
  final int index;
  final Function onSwipe;

  const ItemTile(this.index, this.object, this.onSwipe);

  void onItemSwipe() {
    onSwipe(index, object);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Specify the direction to swipe and delete
      direction: DismissDirection.horizontal,
      key: Key(index.toString() + "-" + object.name!),
      onDismissed: (direction) {
        onItemSwipe();
      },
      background: Container(color: MyColors.accent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(width: 15),
                Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(object.image),
                    ),
                    width: 35,
                    height: 35),
                Container(width: 15),
                Expanded(
                  child: Text(
                    object.name!,
                    style: MyText.medium(context)
                        .copyWith(color: Colors.grey[800]),
                  ),
                ),
                Icon(Icons.swap_horiz, color: MyColors.grey_40),
                Container(width: 15),
              ],
            ),
          ),
          Divider(height: 0)
        ],
      ),
    );
  }

  static void showToastClicked(BuildContext context, String action) {
    print(action);
    MyToast.show(action + " clicked", context);
  }
}
