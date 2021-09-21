import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(12),
      alignment: Alignment.center,
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
            borderSide: BorderSide.none,
          ),
          hintText: 'Password',
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
