import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
      onDone: () {},
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done"),
      pages: [
        PageViewModel(
          decoration: pageDecoration,
          title: "Totor",
          body: "Rate movies and share your filmaking passion with others",
        ),
        PageViewModel(
            decoration: pageDecoration,
            title: "Something witty here",
            body: "Something else here")
      ],
    );
  }
}
