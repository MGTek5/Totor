import 'package:flutter/material.dart';

class MoviePart extends StatelessWidget {
  const MoviePart(
      {Key? key,
      required this.children,
      required this.title,
      this.topPadding = 20,
      this.bottomPadding = 0})
      : super(key: key);
  final List<Widget> children;
  final String title;
  final double topPadding;
  final double bottomPadding;
  final TextStyle sectionTitle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
          child: Text(
            title,
            style: sectionTitle,
          ),
        ),
        ...children
      ],
    );
  }
}
