import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'api.dart';
import 'nav_list.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.m, required this.active})
      : super(key: key);

  final Movie m;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final double blur = active ? 15 : 0;
    final double offset = active ? 7 : 0;
    final double top = active ? 100 : 200;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/movie/details", arguments: {"id": m.id});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(m.getPoster()),
            ),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffEEB868).withOpacity(0.3),
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
      ),
    );
  }
}

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
    return (TextField(
      controller: searchController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Search"),
          icon: Icon(Icons.search)),
    ));
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
