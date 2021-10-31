import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:totor/components/bottom_bar.dart';
import 'package:totor/components/button.dart';
import 'package:totor/models/user.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.3,
                  foregroundImage: NetworkImage(user.profilePic!)),
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
              Fluttertoast.showToast(msg: "See you, ${user.username}");
              Navigator.popAndPushNamed(context, "/login");
            })
          ],
        ),
      ),
    );
  }
}
