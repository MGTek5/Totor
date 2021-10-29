import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:totor/components/button.dart';
import 'package:totor/components/custom_form_field.dart';
import 'package:totor/utils/totor_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:totor/models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _encodedImage = "";
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirm = TextEditingController();
  final _email = TextEditingController();

  Future pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 600,
        maxWidth: 600,
      );
      if (image == null) {
        return;
      }
      final bytes = File(image.path).readAsBytesSync();

      setState(() {
        _encodedImage = base64Encode(bytes);
      });
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Could not get selected image"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("ok"))
                ],
              ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200, child: Image.asset("assets/icon.png")),
            const Text(
              "Welcome!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Text("Sign up to start enjoying all Totor's features"),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !value.contains("@") ||
                              !value.contains(".")) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        hintText: "Email"),
                    CustomFormField(
                        controller: _username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username can't be empty";
                          }
                          return null;
                        },
                        hintText: "Username"),
                    CustomFormField(
                      controller: _password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;
                      },
                      hintText: "Password",
                      obscureText: true,
                    ),
                    CustomFormField(
                        controller: _passwordConfirm,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please confirm password";
                          }
                          if (value != _password.text) {
                            return "Both passwords must match";
                          }
                        },
                        hintText: "Confirm Password"),
                    Button(
                      "Choose picture",
                      () => pickImage(),
                    ),
                    Button("Submit", () async {
                      if (_encodedImage.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return const AlertDialog(
                                title: Text("Missing Picture"),
                                content: Text(
                                    "Please take a picture to use for your profile"),
                              );
                            });
                        return;
                      }
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        try {
                          String imageUrl =
                              await instance.uploadImage(_encodedImage);
                          dynamic res = await instance.register(_email.text,
                              _password.text, _username.text, imageUrl);
                          User user = Provider.of<User>(context, listen: false);
                          user.setEmail(res["email"]);
                          user.setId(res["id"]);
                          user.setProfilePic(res["profilePic"]);
                          user.setUsername(res['username']);
                          user.setLogged(true);
                          Navigator.pushNamed(context, "/");
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: const Text("Could not register"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("ok"))
                                    ],
                                  ));
                        }
                      }
                    })
                  ],
                ))
          ],
        ),
      )),
    ));
    /* return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password Repeat",
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
          Button(
            "Choose picture",
            () => pickImage(),
          ),
          Button("Submit", () async {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              try {
                dynamic res = await instance.register(
                  _email.text,
                  _password.text,
                  _username.text,
                  _encodedImage,
                );
                User user = Provider.of<User>(context, listen: false);
                user.setEmail(res["email"]);
                user.setId(res["id"]);
                user.setProfilePic(res["profilePic"]);
                user.setUsername(res['username']);
                user.setLogged(true);
                Navigator.pushNamed(context, "/");
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text("Could not register"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("ok"))
                          ],
                        ));
              }
            }
          })
        ],
      ),
    ); */
  }
}
