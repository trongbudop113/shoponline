import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppbarContract {
  void goToCartPage();
  void goToFavoritePage();
  void showMessageError(String message, BuildContext buildContext);
  void showDialogLogin(String message);
  void logoutApp();
}

class AppbarPresenter {

  AppbarContract _view;

  AppbarPresenter(this._view);

  final GoogleSignIn googleSignIn = GoogleSignIn();
  var _firebaseAuth = FirebaseAuth.instance;
  static final facebookSignIn = FacebookLoginWeb();

  Future<void> checkLoginGoToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if(isLogin){
      _view.goToCartPage();
    }else{
      _view.showDialogLogin('Bạn cần đăng nhập trước khi thêm vào giỏ hàng.');
    }
  }

  Future<void> handleLogoutApp(AuthNotifier authNotifier) async {
    if(authNotifier.userData.loginBy == "google"){
      googleSignIn.signOut().then((value) {
        clearData().whenComplete(() {
          authNotifier.user = null;
          authNotifier.userData = null;
          authNotifier.count = 0;
        });
      });
    }else if(authNotifier.userData.loginBy == "facebook"){
      facebookSignIn.logOut().then((value) {
        clearData().whenComplete(() {
          authNotifier.user = null;
          authNotifier.userData = null;
          authNotifier.count = 0;
        });
      });
    }else{
      _firebaseAuth.signOut().then((value) {
        clearData().whenComplete(() {
          authNotifier.user = null;
          authNotifier.userData = null;
          authNotifier.count = 0;
        });
      });
    }
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Common.LOGIN);
    prefs.remove(Common.UUID);
    _view.logoutApp();
  }

  Future<void> checkFavoritePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if(isLogin){
      _view.goToFavoritePage();
    }else{
      _view.showDialogLogin('Bạn cần đăng nhập trước khi thêm vào giỏ hàng.');
    }
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}