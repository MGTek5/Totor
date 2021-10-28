import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(this.text, this.onPressed, {Key? key}) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(12),
      child: RawMaterialButton(
        fillColor: const Color(0xffEEB868),
        onPressed: () {
          onPressed();
        },
        child: Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 20)),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(500)),
        elevation: 1,
        constraints: const BoxConstraints(minWidth: 200.0, minHeight: 50),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      )
    );
  }
}