import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:totor/button.dart';

class IntroScreens extends StatelessWidget {
  const IntroScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.black,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      onDone: () {
        GetStorage().write("introSeen", true);
        Navigator.of(context).pushReplacementNamed("/");
      },
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done"),
      pages: [
        PageViewModel(
            decoration: pageDecoration,
            title: "Totor",
            body: "Rate movies and share your movie passion with others",
            image: Image.asset("assets/icon.png")),
        PageViewModel(
            decoration: pageDecoration,
            title: "Discover",
            body: "See what is trending or search for a specific movie",
            image: Image.asset("assets/onboarding/search.png")),
        PageViewModel(
            decoration: pageDecoration,
            title: "Rate",
            body: "Share what you think about a movie with other users",
            image: Image.asset("assets/onboarding/social.png")),
        PageViewModel(
            decoration: pageDecoration,
            title: "Join Us!",
            image: Image.asset("assets/onboarding/signin.png"),
            bodyWidget: Column(
              children: [
                const Text(
                  "In order to be able to use all the features of the app, create an account now!",
                  style: bodyStyle,
                ),
                Button("Sign up", () {
                  GetStorage().write("introSeen", true);
                  Navigator.of(context).pushReplacementNamed("/register");
                })
              ],
            ))
      ],
    );
  }
}
