import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/model/user.dart';

class AuthNotifier with ChangeNotifier {
  FirebaseUser _user;
  UserData _userData;
  int _count = 0;

  FirebaseUser get user => _user;
  UserData get userData => _userData;
  int get count => _count;

  set user(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  set userData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  set count(int count) {
    _count = count;
    notifyListeners();
  }
}
