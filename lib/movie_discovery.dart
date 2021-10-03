import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:totor/arguments.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/nav_list.dart';
import 'package:totor/utils.dart';
import 'api.dart';

class MovieDiscoveryMobile extends StatefulWidget {
  const MovieDiscoveryMobile(
      {Key? key, required this.movies, required this.updateMovies})
      : super(key: key);

  final Function updateMovies;
  final List<Movie> movies;

  @override
  _MovieDiscoveryMobileState createState() => _MovieDiscoveryMobileState();
}

class _MovieDiscoveryMobileState extends State<MovieDiscoveryMobile> {
  PageController controller = PageController(viewportFraction: 0.95);
  int currentPage = 0;

  @override
  initState() {
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
    if (widget.movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return PageView.builder(
      controller: controller,
      itemCount: widget.movies.length,
      itemBuilder: (context, int currentIdx) {
        if (currentIdx == widget.movies.length - 10) {
          widget.updateMovies();
        }
        bool active = currentIdx == currentPage;
        return _buildMoviePage(widget.movies[currentIdx], active);
      },
    );
  }
}

class MovieDiscoveryDesktop extends StatefulWidget {
  const MovieDiscoveryDesktop(
      {Key? key, required this.movies, required this.updateMovies})
      : super(key: key);
  final List<Movie> movies;
  final Function updateMovies;

  @override
  _MovieDiscoveryDesktopState createState() => _MovieDiscoveryDesktopState();
}

class _MovieDiscoveryDesktopState extends State<MovieDiscoveryDesktop> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 20, crossAxisSpacing: 20),
          children: widget.movies
              .map((e) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/movie/details",
                          arguments: MovieDetailsArguments(e.id));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(e.getPoster()),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            e.title,
                            style: const TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isMobile()
          ? SalomonBottomBar(
              items: getNavListMobile(),
              currentIndex: getRouteIndex(context: context),
            )
          : null,
      appBar: isDesktop() ? AppBar() : null,
      drawer: isDesktop()
          ? Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(child: Text("Totor")),
                  ...getNavListDesktop(context: context)
                ],
              ),
            )
          : null,
      body: createPlatformBody(
          desktop: MovieDiscoveryDesktop(
              movies: _data,
              updateMovies: () {
                getMovies(page: lastPage + 1);
              }),
          mobile: MovieDiscoveryMobile(
            movies: _data,
            updateMovies: () {
              getMovies(page: lastPage + 1);
            },
          )),
    );
  }
}
