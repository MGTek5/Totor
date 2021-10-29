import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:totor/components/button.dart';
import 'package:totor/components/custom_form_field.dart';
import 'package:totor/utils/totor_api.dart';
import 'package:totor/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _email = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 200, child: Image.asset("assets/icon.png")),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const Text("Sign in with your email and password"),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: _email,
                          hintText: "Email",
                          validator: (String? value) {
                            if (value!.isEmpty ||
                                !value.contains("@") ||
                                !value.contains(".")) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                        ),
                        CustomFormField(
                          controller: _password,
                          hintText: "Password",
                          obscureText: true,
                          validator: (String? value) {},
                        ),
                        Button("Login", () async {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                _loading = true;
                              });
                              dynamic res = await instance.login(
                                _email.text,
                                _password.text,
                              );
                              User user =
                                  Provider.of<User>(context, listen: false);
                              user.setEmail(res["email"]);
                              user.setId(res["id"]);
                              user.setProfilePic(res["profilePic"]);
                              user.setUsername(res['username']);
                              user.setLogged(true);
                              GetStorage().write("loggedIn", true);
                              GetStorage().write("user", user.toJson());
                              setState(() {
                                _loading = false;
                              });
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
                      ],
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.orange,
                          textStyle: const TextStyle(fontSize: 12)),
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text("Create an account"))
                ]),
            if (_loading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.9)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    Text("Loading, please wait")
                  ],
                ),
              )
          ],
        ),
      )),
    ));
  }
}
