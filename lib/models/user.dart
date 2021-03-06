import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  bool _logged = false;
  String? _email;
  String? _username;
  String? _profilePic;
  String? _id;

  bool get logged => _logged;
  String? get email => _email;
  String? get profilePic => _profilePic;
  String? get id => _id;
  String? get username => _username;

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

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setId(String id) {
    _id = id;
    notifyListeners();
  }

  void signOut() {
    _email = null;
    _logged = false;
    _profilePic = null;
    _username = null;
    _id = null;
  }

  void signIn(String id, String email, String username, String profilePic) {
    _id = id;
    _email = email;
    _username = username;
    _profilePic = profilePic;
    _logged = true;
  }

  dynamic toJson() {
    return {
      "email": _email,
      "logged": _logged,
      "profilePic": _profilePic,
      "username": _username,
      "id": _id
    };
  }

  User();
}
