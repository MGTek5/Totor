import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.4,
              foregroundImage: Image.network(
                "https://avatars.githubusercontent.com/u/40118153?v=4",
              ).image,
            ),
            Text(user.username!),
            Text(user.email!)
          ],
        ),
      ),
    );
  }
}
