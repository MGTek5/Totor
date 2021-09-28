import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totor/image_full.dart';
import 'package:totor/models/user.dart';
import 'package:totor/movie_details.dart';
import 'package:totor/search.dart';
import 'movie_discovery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(
          create: (_) => User(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => const MovieDiscovery(),
            "/search": (context) => const Search(),
            "/movie/details": (context) => const MovieDetails(),
            "/imagefull": (context) => const ImageFull()
          }),
    );
  }
}
