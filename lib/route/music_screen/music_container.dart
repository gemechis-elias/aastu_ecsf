import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MusicContainer extends StatelessWidget {
  const MusicContainer({
    super.key,
    required this.albumData,
  });

  final Map albumData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162.0,
      // height: 150.0,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        // color: Colors.grey[900]!,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160.0,
            height: 160.0,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: albumData["albumArt"],
              progressIndicatorBuilder: (context, string, progress) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              },
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            albumData["title"].toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            albumData["artist"].toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
