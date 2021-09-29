import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  bool _logged = false;
  String? _email;
  String? _profilePic;
  String? _token;

  bool get logged => _logged;
  String? get email => _email;
  String? get profilePic => _profilePic;
  String? get token => _token;

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

  void setToken(String token) {
    _token = token;
  }

  User();
}
