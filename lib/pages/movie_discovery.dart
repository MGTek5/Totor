import 'package:flutter/material.dart';
import 'package:totor/components/bottom_bar.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/utils/tmdb.dart';

class MovieDiscovery extends StatefulWidget {
  const MovieDiscovery({Key? key}) : super(key: key);

  @override
  _MovieDiscoveryState createState() => _MovieDiscoveryState();
}

class _MovieDiscoveryState extends State<MovieDiscovery> {
  List<Movie> _data = [];
  int _lastPage = 1;
  void _getMovies({int page = 1}) async {
    List<Movie> data = await instance.getTrendingMovies(page: page);
    setState(() {
      _data = _data + data;
      _lastPage = page;
    });
  }

  @override
  initState() {
    super.initState();
    _getMovies();
  }

  Widget _buildMoviePage(Movie m, bool active) {
    return MovieCard(movie: m, active: active);
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(child: CircularProgressIndicator.adaptive()),
              Text("Loading latest movies, please wait")
            ],
          ),
        ),
      );
    }
    return Scaffold(
        bottomNavigationBar: const BottomBar(),
        body: Carousel(
            vFraction: 0.90,
            itemCount: _data.length,
            buildItem: (BuildContext ctx, int idx, bool active) {
              if (idx == _data.length - 10) {
                _getMovies(page: _lastPage + 1);
              }
              return _buildMoviePage(_data[idx], active);
            }));
  }
}
