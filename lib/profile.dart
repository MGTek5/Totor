import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:totor/components/button.dart';

import 'models/user.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.3,
                  foregroundImage: MemoryImage(base64Decode(user.profilePic!))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                user.username!,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              user.email!,
              style: const TextStyle(fontSize: 20),
            ),
            Button("Sign Out", () {
              GetStorage().write("loggedIn", false);
              GetStorage().write("user", null);
              Navigator.popAndPushNamed(context, "/login");
            })
          ],
        ),
      ),
    );
  }
}
