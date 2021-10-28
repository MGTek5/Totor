import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:totor/components/button.dart';
import 'package:totor/register.dart';
import 'package:totor/totoapi.dart';

import 'package:provider/provider.dart';

import 'models/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<User>().signOut();

    return const Scaffold(
      resizeToAvoidBottomInset: false,
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
    final _password = TextEditingController();
    final _email = TextEditingController();
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
          const Text("Sign in with your email and password"),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !value.contains("@") ||
                          !value.contains(".")) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
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
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _password,
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
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
              ],
            ),
          ),
          Button("Login", () async {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              try {
                dynamic res = await instance.login(
                  _email.text,
                  _password.text,
                );
                User user = Provider.of<User>(context, listen: false);
                user.setEmail(res["email"]);
                user.setId(res["id"]);
                user.setProfilePic(res["profilePic"]);
                user.setUsername(res['username']);
                user.setLogged(true);
                GetStorage().write("loggedIn", true);
                GetStorage().write("user", user.toJson());
                Navigator.pushNamed(context, '/');
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Could not sign in"),
                        content: Text(e.toString()),
                      );
                    });
              }
            }
          }),
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
