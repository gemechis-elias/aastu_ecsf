import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

class ListDraggableAdapter {
  List? items = <People>[];
  Function onReorder;

  ListDraggableAdapter(this.items, this.onReorder);

  Widget getView() {
    return ReorderableListView(
      onReorder: _onReorder,
      scrollDirection: Axis.vertical,
      children: List.generate(
        this.items!.length,
        (index) {
          return ItemTile(Key('$index'), index, this.items![index]);
        },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final People item = this.items!.removeAt(oldIndex);
    this.items!.insert(newIndex, item);
    this.onReorder();
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final People object;
  final int index;
  final Key key;

  const ItemTile(this.key, this.index, this.object);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          key: PageStorageKey<int>(index),
          leading: Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(object.image),
              ),
              width: 35,
              height: 35),
          title: Text(object.name!,
              style: MyText.medium(context).copyWith(color: Colors.grey[800])),
          trailing: Icon(Icons.menu, color: MyColors.grey_40),
        ),
        Divider(height: 0)
      ],
    );
  }

  static void showToastClicked(BuildContext context, String action) {
    print(action);
    MyToast.show(action + " clicked", context);
  }
}
