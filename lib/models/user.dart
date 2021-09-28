import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  bool _logged = false;
  String? _email;
  String? _profilePic;

  bool getLogged() => _logged;
  String? getEmail() => _email;
  String? getProfilePic() => _profilePic;
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setLogged(bool logged) {
    _logged = logged;
    notifyListeners();
  }

  void setProfilePic(String profilePic) {
    _profilePic = profilePic;
    notifyListeners();
  }

  User();
}
