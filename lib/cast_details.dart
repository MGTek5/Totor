import 'package:flutter/material.dart';

class CastDetails extends StatefulWidget {
  const CastDetails({Key? key}) : super(key: key);

  @override
  _CastDetailsState createState() => _CastDetailsState();
}

class _CastDetailsState extends State<CastDetails> {
  bool firstTime = true;

  @override
  void didChangeDependencies() {
    if (firstTime) {
      setState(() {
        firstTime = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
