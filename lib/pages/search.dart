import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totor/components/bottom_bar.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/utils/tmdb.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<Movie>> _searchMovies({required String query}) {
    try {
      return instance.searchMovie(query: query);
    } catch (e) {
      rethrow;
    }
  }

  void _handleSearchChange() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults = [];
      });
    }
    if (_searchController.text.isNotEmpty &&
        _searchController.text.length % 3 == 0) {
      setState(() {
        _loading = true;
      });
      try {
        List<Movie> tmp = await _searchMovies(query: _searchController.text);
        setState(() {
          _searchResults = tmp;
          _loading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ooops: ${e.toString()}"),
        ));
      }
    }
  }

  List<Movie> _searchResults = [];
  bool _loading = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearchChange);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Widget _buildMoviePage(Movie m, bool active) {
    return MovieCard(movie: m, active: active);
  }

  Widget buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: (TextField(
        controller: _searchController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            label: Text("Search"),
            icon: Icon(Icons.search)),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSearchInput(),
          if (_loading) ...[const CircularProgressIndicator.adaptive()],
          if (_searchResults.isEmpty)
            const Text("Nothing to see here, start typing to see some results"),
          if (_searchResults.isNotEmpty)
            Expanded(
              child: Carousel(
                itemCount: _searchResults.length,
                vFraction: 0.85,
                buildItem: (context, int currentIdx, bool active) {
                  return _buildMoviePage(_searchResults[currentIdx], active);
                },
              ),
            )
        ],
      )),
    ));
  }
}
