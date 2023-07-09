import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/model/blog_model.dart';

class BlogListAdapter {
  List items = <Blog>[];
  List itemsTile = <ItemTile>[];

  BlogListAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  SliverList getView() {
    return SliverList(
        delegate: SliverChildListDelegate(itemsTile as List<Widget>));
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final Blog object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(Blog obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(object);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          children: <Widget>[
            Card(
                margin: const EdgeInsets.all(0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  imageUrl: object.image,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 24, // Adjust the size as needed
                      height: 24, // Adjust the size as needed
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            Container(height: 10),
            Row(
              children: <Widget>[
                Text(object.author,
                    style: MyText.body2(context)!.copyWith(
                        fontFamily: 'MyFont', color: MyColors.grey_40)),
                const Spacer(),
                Text(object.date,
                    style: MyText.body1(context)!.copyWith(
                        fontFamily: 'MyFont', color: MyColors.grey_40)),
              ],
            ),
            Container(height: 10),
            Text(
              object.title,
              style: MyText.medium(context).copyWith(
                  fontFamily: 'MyFont',
                  fontSize: 16,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(height: 10),
            const Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
