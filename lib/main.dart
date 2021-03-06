import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:totor/pages/genres.dart';
import 'package:totor/pages/image_full.dart';
import 'package:totor/pages/login.dart';
import 'package:totor/pages/cast_details.dart';
import 'package:totor/models/user.dart';
import 'package:totor/pages/movie_details.dart';
import 'package:totor/pages/profile.dart';
import 'package:totor/pages/search.dart';
import 'package:totor/pages/register.dart';
import 'pages/intro_screens.dart';
import 'pages/movie_discovery.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<User>(
            create: (_) {
              User u = User();
              if (GetStorage().read<bool>("loggedIn") ?? false == true) {
                dynamic data = GetStorage().read("user");
                u.signIn(data["id"], data["email"], data["username"],
                    data["profilePic"]);
              } else {
                GetStorage().write("loggedIn", false);
                GetStorage().write("user", null);
              }
              return u;
            },
          )
        ],
        child: MaterialApp(
            title: 'Totor',
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
              "/movie/genre": (context) => const GenresPage(),
              "/register": (context) => const RegisterPage(),
              "/login": (context) => const LoginPage(),
              "/imagefull": (context) => const ImageFull(),
              '/profile': (context) => context.read<User>().logged
                  ? const Profile()
                  : const LoginPage(),
              "/cast/details": (context) => const CastDetails(),
            }));
  }
}
