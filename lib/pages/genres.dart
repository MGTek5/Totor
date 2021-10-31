import 'package:flutter/material.dart';
import 'package:totor/utils/arguments.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/genre.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/utils/tmdb.dart';

class GenresPage extends StatefulWidget {
  const GenresPage({Key? key}) : super(key: key);

  @override
  _GenresPageState createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  bool _firstTime = true;
  bool _loading = true;
  final List<Movie> _movies = [];
  late Genre _genre;

  _getMovies() async {
    List<Movie> tmp = await instance.getMoviesWithGenre(id: _genre.id);
    setState(() {
      _movies.addAll(tmp);
      _loading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_firstTime) {
      final GenreDiscoveryArguments args =
          ModalRoute.of(context)!.settings.arguments as GenreDiscoveryArguments;
      setState(() {
        _firstTime = false;
        _genre = args.genre;
      });
      _getMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: CircularProgressIndicator.adaptive()),
            Text("Looking for movies in ${_genre.name}")
          ],
        )),
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Discover Movies in ${_genre.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            child: Carousel(
                buildItem: (context, int idx, bool active) {
                  return MovieCard(movie: _movies[idx], active: active);
                },
                vFraction: 0.85,
                itemCount: _movies.length),
          ),
        ],
      )),
    );
  }
}
