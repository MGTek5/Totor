import 'package:flutter/material.dart';
import 'package:totor/utils/arguments.dart';

class ImageFull extends StatelessWidget {
  const ImageFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageFullArguments args =
        ModalRoute.of(context)!.settings.arguments as ImageFullArguments;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(args.path),
        ),
      ),
    );
  }
}
