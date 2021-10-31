import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totor/utils/arguments.dart';
import 'package:totor/models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {Key? key,
      required Movie movie,
      required bool active,
      double activeTop = 100,
      double inactiveTop = 200,
      double activeBlur = 15,
      double inactiveBlur = 0,
      double activeOffset = 7,
      double inactiveOffset = 0})
      : _movie = movie,
        _active = active,
        _activeTop = activeTop,
        _inactiveTop = inactiveTop,
        _activeBlur = activeBlur,
        _inactiveBlur = inactiveBlur,
        _activeOffset = activeOffset,
        _inactiveOffset = inactiveOffset,
        super(key: key);

  final Movie _movie;
  final bool _active;
  final double _activeTop;
  final double _inactiveTop;
  final double _activeOffset;
  final double _inactiveOffset;
  final double _activeBlur;
  final double _inactiveBlur;

  @override
  Widget build(BuildContext context) {
    final double blur = _active ? _activeBlur : _inactiveBlur;
    final double offset = _active ? _activeOffset : _inactiveOffset;
    final double top = _active ? _activeTop : _inactiveTop;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/movie/details",
            arguments: MovieDetailsArguments(_movie.id));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(_movie.getPoster()),
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
