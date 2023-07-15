import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/model/section_image.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:skeletons/skeletons.dart';

class GridSectionedAdapter {
  List<SectionImage> items = <SectionImage>[];
  List<ItemTile> itemsTile = <ItemTile>[];

  GridSectionedAdapter(this.items, onItemClick) {
    // Sort the items list in reverse order

    for (var i = 0; i < items.length; i++) {
      items.sort((a, b) => b.title.compareTo(a.title));
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(5),
      crossAxisCount: 3,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => itemsTile[index],
      staggeredTileBuilder: (int index) => StaggeredTile.count(
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
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(object.title,
                style: MyText.subhead(context)!.copyWith(
                    fontFamily: 'MyFont',
                    color: MyColors.grey_40,
                    fontWeight: FontWeight.bold)),
          )
        : Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // change SectionImage to List<SectionImage>
                  List<SectionImage> object = [];
                  object.add(this.object);
                  log("Photo info: $object");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImage(
                        images: object,
                        title: this.object.title,
                        initialIndex: 0,
                      ),
                    ),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: object.image,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          );
  }
}

class FullScreenImage extends StatefulWidget {
  final List<SectionImage> images;
  final int initialIndex;
  final String title;

  const FullScreenImage(
      {Key? key,
      required this.images,
      required this.title,
      required this.initialIndex})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  int _currentIndex = 0;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'MyFont',
          ),
        ),
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 2.0,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index].image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              controller: PageController(initialPage: _currentIndex),
            ),
          ],
        ),
      ),
    );
  }
}
