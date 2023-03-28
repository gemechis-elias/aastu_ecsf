import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleImage extends StatelessWidget {

  final double? size;
  final Color? backgroundColor;
  final ImageProvider imageProvider;

  const CircleImage({
    Key? key,
    required this.imageProvider,
    this.size,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    return Container(
        width: size != null ? size : 20,
        height: size != null ? size : 20,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor != null ? backgroundColor : Colors.transparent,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: imageProvider
            )
        )
    );
  }
}
