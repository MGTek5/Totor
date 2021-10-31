import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel(
      {Key? key,
      required this.buildItem,
      required this.itemCount,
      this.vFraction = 0.5})
      : super(key: key);

  final Widget Function(BuildContext, int idx, bool active) buildItem;
  final double vFraction;
  final int itemCount;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentPage = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.vFraction);
    _controller.addListener(() {
      int next = _controller.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.itemCount,
      itemBuilder: (BuildContext ctx, int idx) {
        bool active = idx == _currentPage;
        return widget.buildItem(ctx, idx, active);
      },
      controller: _controller,
    );
  }
}
