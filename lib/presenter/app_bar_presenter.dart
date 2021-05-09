import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppbarContract {
  void goToCartPage();
  void showMessageError(String message, BuildContext buildContext);
  void showDialogLogin(String message);
}

class AppbarPresenter {

  AppbarContract _view;

  AppbarPresenter(this._view);

  Future<void> checkLoginGoToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if(isLogin){
      _view.goToCartPage();
    }else{
      _view.showDialogLogin('aaaaaaaaa');
    }
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}