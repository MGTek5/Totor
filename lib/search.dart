import 'package:flutter/material.dart';

import 'api.dart';

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
        List<ListTile> tmp = [];

        for (var element in value) {
          tmp.add(ListTile(
              title: Text(element.title),
              leading: Image.network(element.getPoster()),
              onTap: () {
                Navigator.pushNamed(context, "/movie/details",
                    arguments: {"id": element.id});
              }));
        }

        setState(() {
          searchResults = tmp;
          loading = false;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ooops: $error"),
        ));
      });
    }
  }

  List<ListTile> searchResults = [];
  bool loading = false;
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

  Widget buildSearchInput() {
    return (TextField(controller: searchController, decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Search"),
                  icon: Icon(Icons.search)
                ),));
  }

  @override
  Widget build(BuildContext context) {

    return (
      Scaffold(
        body: SafeArea(child: 
          SingleChildScrollView(
            primary: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSearchInput(),
                if (loading) ...[
                  const CircularProgressIndicator()
                ],
                if (searchResults.isEmpty)
                  const Text("Nothing to see here, start typing to see some results"),
                ...searchResults
              ],
            ),
          )
        ),
      )
    );
  }
}
