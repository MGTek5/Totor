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
<<<<<<< master
      child: TextField(
=======
      child: const TextField(
>>>>>>> Add new component input
=======
      child: TextField(
>>>>>>> [add] text varible in hint text
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
<<<<<<< master
<<<<<<< master
          border: const OutlineInputBorder(
=======
          border: OutlineInputBorder(
>>>>>>> Add new component input
=======
          border: const OutlineInputBorder(
>>>>>>> [add] text varible in hint text
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
            borderSide: BorderSide.none,
          ),
<<<<<<< master
<<<<<<< master
          hintText: text,
=======
          hintText: 'Password',
>>>>>>> Add new component input
=======
          hintText: text,
>>>>>>> [add] text varible in hint text
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
