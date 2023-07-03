import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WallpaperAdapter {
  List<String> items = [];
  List<Widget> itemsTile = [];

  WallpaperAdapter(this.items, onItemClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      padding: const EdgeInsets.all(2),
      crossAxisCount: 2,
      children: itemsTile,
    );
  }
}

class ItemTile extends StatelessWidget {
  final String object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  }) : super(key: key);

  void onItemClick(String obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemClick(object);
      },
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: object,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) {
              if (error is SocketException) {
                return Image.asset(
                  'assets/images/no_image.png', // Replace with your placeholder image path
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              } else {
                return const Icon(Icons.error);
              }
            },
          ),
        ],
      ),
    );
  }
}
