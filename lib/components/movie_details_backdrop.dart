import 'package:flutter/material.dart';

class MovieDetailsBackdrop extends StatelessWidget {
  const MovieDetailsBackdrop(
      {Key? key, required this.content, required this.backdrop})
      : super(key: key);
  final Widget content;
  final String backdrop;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(backdrop), fit: BoxFit.cover)),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
        child: content,
      ),
    );
  }
}
