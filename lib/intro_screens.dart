import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreens extends StatelessWidget {
  const IntroScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: "Totor",
            body: "Rate movies and share your filmaking passion with others",
            image: Image.asset("assets/icon.png"))
      ],
    );
  }
}
