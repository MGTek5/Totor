import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totor/image_full.dart';
import 'package:totor/movie_details.dart';
import 'package:totor/search.dart';

import 'intro_screens.dart';
import 'movie_discovery.dart';

void main() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(MyApp(sPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.sPreferences}) : super(key: key);

  final SharedPreferences sPreferences;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => sPreferences.getBool("introSeen") ?? false
              ? const MovieDiscovery()
              : const IntroScreens(),
          "/search": (context) => const Search(),
          "/movie/trending": (context) => const MovieDiscovery(),
          "/movie/details": (context) => const MovieDetails(),
          "/imagefull": (context) => const ImageFull()
        });
  }
}
