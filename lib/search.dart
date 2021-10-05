import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/models/movie.dart';

import 'tmdb.dart';
import 'nav_list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void handleSearchChange() {
    if (searchController.text.isEmpty) {
      setState(() {
        searchResults = [];
      });
    }
    if (searchController.text.isNotEmpty &&
        searchController.text.length % 3 == 0) {
      setState(() {
        loading = true;
      });
      instance.searchMovie(query: searchController.text).then((value) {
        if (searchResults.isNotEmpty) {
          pageController.animateToPage(0,
              curve: Curves.ease, duration: const Duration(seconds: 1));
        }
        setState(() {
          searchResults = value;
          loading = false;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ooops: $error"),
        ));
      });
    }
  }

  List<Movie> searchResults = [];
  bool loading = false;
  TextEditingController searchController = TextEditingController();
  PageController pageController = PageController(viewportFraction: 0.95);
  int currentPage = 0;
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    searchController.addListener(handleSearchChange);
    pageController.addListener(() {
      int next = pageController.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
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
          if (searchResults.isEmpty)
            const Text("Nothing to see here, start typing to see some results"),
          if (searchResults.isNotEmpty)
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: searchResults.length,
                itemBuilder: (context, int currentIdx) {
                  bool active = currentIdx == currentPage;
                  return _buildMoviePage(searchResults[currentIdx], active);
                },
              ),
            )
        ],
      )),
    ));
  }
}
