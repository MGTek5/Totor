import 'package:flutter/material.dart';

import 'api.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void handleSearchChange() {
    if (searchController.text.isNotEmpty &&
        searchController.text.length % 3 == 0) {
      instance.searchMovie(query: searchController.text).then((value) {
        List<ListTile> tmp = [];

        for (var element in value) {
          tmp.add(ListTile(
              title: Text(element.title),
              onTap: () {
                Navigator.pushNamed(context, "/movie/details",
                    arguments: {"id": element.id});
              }));
        }

        setState(() {
          searchResults = tmp;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ooops: $error"),
        ));
      });
    }
  }

  List<ListTile> searchResults = [];
  TextEditingController searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(controller: searchController),
                ...searchResults
              ]),
        ),
      ),
    );
  }
}
