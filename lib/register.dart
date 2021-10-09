import 'package:flutter/material.dart';
import 'package:totor/components/button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        actions: const <Widget>[],
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    String name;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 54,
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
                labelText: "Username",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 54,
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
                hintText: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 54,
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
                hintText: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 54,
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
                hintText: "Repeat Password",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 54,
              child: Button("Submit", () {})),
        ],
      ),
    );
  }
}
