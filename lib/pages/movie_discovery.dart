import 'package:flutter/material.dart';
import 'package:totor/components/bottom_bar.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/utils/misc.dart';
import 'package:totor/utils/nav_list.dart';
import 'package:totor/utils/tmdb.dart';

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
        bottomNavigationBar: !isDesktop() ? const BottomBar() : null,
        appBar: isDesktop()
            ? AppBar(
                title: const Text("Totor"),
              )
            : null,
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(child: Text("Totor")),
              ...getDrawerNav(context)
            ],
          ),
        ),
        body: isMobile()
            ? Carousel(
                vFraction: 0.90,
                itemCount: _data.length,
                buildItem: (BuildContext ctx, int idx, bool active) {
                  if (idx == _data.length - 10) {
                    getMovies(page: lastPage + 1);
                  }
                  return _buildMoviePage(_data[idx], active);
                })
            : Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: (GridView.builder(
                    itemCount: _data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 5),
                    itemBuilder: (ctx, int idx) {
                      return _buildMoviePage(_data[idx], false);
                    })),
              ));
  }
}
