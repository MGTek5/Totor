import 'package:flutter/material.dart';
import 'package:totor/components/button.dart';
import 'package:totor/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //String email;
    //String password;
    //String name;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: Image.asset("assets/icon.png"),
            height: 230,
          ),
          const Text(
            "Welcome Back",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text("Sign in with yout email and password"),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //height: 54,
            child: const TextField(
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //height: 54,
            child: const TextField(
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Button("Login", () {}),
          TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: const TextStyle(fontSize: 12)),
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    )
                  },
              child: const Text("Create an account")),
        ],
      ),
    );
  }
}
