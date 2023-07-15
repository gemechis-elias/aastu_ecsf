import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:aastu_ecsf/model/blog_model.dart';
import 'package:skeletons/skeletons.dart';

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
                  placeholder: (context, url) => SkeletonItem(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF222222),
                            Color(0xFF242424),
                            Color(0xFF2B2B2B),
                            Color(0xFF242424),
                            Color(0xFF222222),
                          ],
                        ),
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
