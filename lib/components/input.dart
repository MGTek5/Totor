import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(12),
      alignment: Alignment.center,
<<<<<<< master
      child: TextField(
=======
      child: const TextField(
>>>>>>> Add new component input
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
<<<<<<< master
          border: const OutlineInputBorder(
=======
          border: OutlineInputBorder(
>>>>>>> Add new component input
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
            borderSide: BorderSide.none,
          ),
<<<<<<< master
          hintText: text,
=======
          hintText: 'Password',
>>>>>>> Add new component input
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
