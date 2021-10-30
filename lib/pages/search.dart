import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';

import '../utils/tmdb.dart';
import '../utils/nav_list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void handleSearchChange() {
    if (searchController.text.isEmpty) {
      setState(() {
        _searchResults = [];
      });
    }
    if (searchController.text.isNotEmpty &&
        searchController.text.length % 3 == 0) {
      setState(() {
        loading = true;
      });
      instance.searchMovie(query: searchController.text).then((value) {
        setState(() {
          _searchResults = value;
          loading = false;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ooops: $error"),
        ));
      });
    }
  }

  List<Movie> _searchResults = [];
  bool loading = false;
  TextEditingController searchController = TextEditingController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    searchController.addListener(handleSearchChange);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Widget _buildMoviePage(Movie m, bool active) {
    return MovieCard(m: m, active: active);
  }

  Widget buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: (TextField(
        controller: searchController,
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
      bottomNavigationBar: SalomonBottomBar(
        items: getNavList(),
        onTap: (index) {
          navigateTo(context: context, index: index);
        },
        currentIndex: getRouteIndex(context: context),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSearchInput(),
          if (loading) ...[const CircularProgressIndicator()],
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
