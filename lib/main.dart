import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:totor/image_full.dart';
import 'package:totor/models/user.dart';
import 'package:totor/movie_details.dart';
import 'package:totor/search.dart';
import 'package:totor/register.dart';
import 'intro_screens.dart';
import 'movie_discovery.dart';

void main() async {
  await GetStorage.init();
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
              "/": (context) => GetStorage().read<bool>("introSeen") ?? false
                  ? const MovieDiscovery()
                  : const IntroScreens(),
              "/search": (context) => const Search(),
              "/movie/details": (context) => const MovieDetails(),
              "/imagefull": (context) => const ImageFull(),
              "/register": (context) => const RegisterPage(),
            }));
  }
}
