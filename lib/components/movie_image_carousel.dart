import 'package:flutter/material.dart';
import 'package:totor/utils/arguments.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, required this.path, required this.active})
      : super(key: key);

  final String path;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final double blur = active ? 15 : 0;
    final double offset = active ? 7 : 0;
    final double top = active ? 20 : 70;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/imagefull",
            arguments: ImageFullArguments(path));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(path),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
      ),
    );
  }
}
