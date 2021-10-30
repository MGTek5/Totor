import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totor/utils/arguments.dart';
import 'package:totor/models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.m, required this.active})
      : super(key: key);

  final Movie m;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final double blur = active ? 15 : 0;
    final double offset = active ? 7 : 0;
    final double top = active ? 100 : 200;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/movie/details",
            arguments: MovieDetailsArguments(m.id));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(m.getPoster()),
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
