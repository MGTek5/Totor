import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'api.dart';

class MovieDiscovery extends StatefulWidget {
  MovieDiscovery({Key? key}) : super(key: key);

  @override
  _MovieDiscoveryState createState() => _MovieDiscoveryState();
}

class _MovieDiscoveryState extends State<MovieDiscovery> {
  Map _data = null;

  @override
  Future<void> initState() async {
    super.initState();
    Map data = await api.v3.trending.getTrending(mediaType: MediaType.movie);
    
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
