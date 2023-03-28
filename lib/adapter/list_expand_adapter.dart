import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/model/people.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

class ListExpandAdapter {
  List? items = <People>[];
  List itemsTile = <ItemTile>[];

  ListExpandAdapter(this.items) {
    for (var i = 0; i < items!.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items![i]));
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
  final People object;
  final int index;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          leading: Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(object.image),
              ),
              width: 35,
              height: 35),
          key: PageStorageKey<int>(index),
          title: Text(object.name!,
              style: MyText.medium(context).copyWith(color: Colors.grey[800])),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              color: MyColors.grey_5,
              child: Text(MyStrings.lorem_ipsum,
                  textAlign: TextAlign.justify,
                  style:
                      MyText.body1(context)!.copyWith(color: Colors.grey[800])),
            )
          ],
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
