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
  bool firstTime = true;
  bool loading = true;
  int moviePage = 1;
  List<Movie> movies = [];
  late Genre genre;

  getMovies() async {
    List<Movie> tmp = await instance.getMoviesWithGenre(id: genre.id);
    setState(() {
      movies.addAll(tmp);
      loading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTime) {
      final GenreDiscoveryArguments args =
          ModalRoute.of(context)!.settings.arguments as GenreDiscoveryArguments;
      setState(() {
        firstTime = false;
        genre = args.genre;
      });
      getMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: CircularProgressIndicator.adaptive()),
            Text("Looking for movies in ${genre.name}")
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
              "Discover Movies in ${genre.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            child: Carousel(
                buildItem: (context, int idx, bool active) {
                  return MovieCard(movie: movies[idx], active: active);
                },
                vFraction: 0.85,
                itemCount: movies.length),
          ),
        ],
      )),
    );
  }
}
