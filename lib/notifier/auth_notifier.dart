import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier with ChangeNotifier {
  FirebaseUser _user;
  int _count = 0;

  FirebaseUser get user => _user;
  int get count => _count;

  set user(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  set count(int count) {
    _count = count;
    notifyListeners();
  }
}
