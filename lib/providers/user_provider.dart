import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _loggedIn = false;

  void setLogged(bool l) {
    _loggedIn = l;
    notifyListeners();
  }

  bool getLogged() {
    return _loggedIn;
  }
}
