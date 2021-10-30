import 'package:flutter/material.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';

class CastMovieCarousel extends StatefulWidget {
  const CastMovieCarousel({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;
  @override
  _CastMovieCarouselState createState() => _CastMovieCarouselState();
}

class _CastMovieCarouselState extends State<CastMovieCarousel> {
  int currentPage = 1;
  PageController controller = PageController(viewportFraction: 0.95);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int next = controller.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  Widget _buildMoviePage(Movie m, bool active) {
    return MovieCard(m: m, active: active);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: widget.movies.length,
      itemBuilder: (context, int currentIdx) {
        bool active = currentIdx == currentPage;
        return _buildMoviePage(widget.movies[currentIdx], active);
      },
    );
  }
}
