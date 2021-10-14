import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/nav_list.dart';
import 'tmdb.dart';

class MovieDiscovery extends StatefulWidget {
  const MovieDiscovery({Key? key}) : super(key: key);

  @override
  _MovieDiscoveryState createState() => _MovieDiscoveryState();
}

class _MovieDiscoveryState extends State<MovieDiscovery> {
  List<Movie> _data = [];
  int lastPage = 1;
  void getMovies({int page = 1}) async {
    List<Movie> data = await instance.getTrendingMovies(page: page);
    setState(() {
      _data = _data + data;
      lastPage = page;
    });
  }

  @override
  initState() {
    super.initState();
    getMovies();
  }

  Widget _buildMoviePage(Movie m, bool active) {
    return MovieCard(m: m, active: active);
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          items: getNavList(),
          onTap: (index) {
            navigateTo(context: context, index: index);
          },
          currentIndex: getRouteIndex(context: context),
        ),
        body: Carousel(
            vFraction: 0.90,
            buildItem: (BuildContext ctx, int idx, bool active) {
              if (idx == _data.length - 10) {
                getMovies(page: lastPage + 1);
              }
              return _buildMoviePage(_data[idx], active);
            }));
  }
}
