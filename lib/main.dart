import 'package:flutter/material.dart';
import 'package:totor/movie_details.dart';

import 'movie_discovery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MovieDiscovery(),
          "/movie/details": (context) => const MovieDetails()
        });
  }
}
