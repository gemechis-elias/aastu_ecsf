import 'package:flutter/widgets.dart';
import '../utils/delay_tween.dart';

/*
 Dot bounce progress animation
 */

class WidgetDotBounce extends StatefulWidget {

  const WidgetDotBounce({
    Key? key,
    this.color,
    this.size = 18.0, this.count = 3,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 300),
    this.controller,
  })  : assert(!(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
  'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final int count;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  WidgetDotBounceState createState() => WidgetDotBounceState();

}

class WidgetDotBounceState extends State<WidgetDotBounce> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.count * widget.duration.inMilliseconds))
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 3.2, widget.size * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.count, (i) {
            return SlideTransition(
              position: DelayTweenOffset(begin: Offset(0, 0.5), end: Offset(0, -0.5), delay: i * 0.2).animate(_controller),
              child: SizedBox.fromSize(size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle));
}

/*
 Dot grow progress animation
 */

class WidgetDotGrow extends StatefulWidget {

  const WidgetDotGrow({
    Key? key,
    this.color,
    this.size = 18.0, this.count = 3,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 300),
    this.controller,
  })  : assert(!(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
  'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final int count;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  WidgetDotGrowState createState() => WidgetDotGrowState();

}

class WidgetDotGrowState extends State<WidgetDotGrow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.count * widget.duration.inMilliseconds))
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 3.5, widget.size * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.count, (i) {
            return ScaleTransition(
              scale: DelayTween(begin: 1.0, end: 1.3, delay: i * 0.2).animate(_controller),
              child: SizedBox.fromSize(size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle));
}

/*
 Dot fade progress animation
 */

class WidgetDotFade extends StatefulWidget {

  const WidgetDotFade({
    Key? key,
    this.color,
    this.size = 18.0,
    this.count = 3,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 500),
    this.controller,
  })  : assert(!(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
  'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final int count;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  WidgetDotFadeState createState() => WidgetDotFadeState();

}

class WidgetDotFadeState extends State<WidgetDotFade> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.count * widget.duration.inMilliseconds))
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 3.2, widget.size * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.count, (i) {
            return FadeTransition(
              opacity: DelayTween(begin: 0.1, end: 1.0, delay: i * 0.2).animate(_controller),
              child: SizedBox.fromSize(size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle));
}