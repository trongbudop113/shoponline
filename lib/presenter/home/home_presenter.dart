import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeContract {
  void goToCartDetail();
  void goToLogin();
  void goToWishList();
  void showMessageError(String message, BuildContext buildContext);
}

class HomePresenter {

  HomeContract _view;

  HomePresenter(this._view);

  goToCartDetail(BuildContext mContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(Common.LOGIN) ?? false;
    if(intValue){
      _view.goToCartDetail();
    }else{
      _view.goToLogin();
    }
  }

  goToWishList(BuildContext mContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(Common.LOGIN) ?? false;
    if(intValue){
      _view.goToWishList();
    }else{
      _view.goToLogin();
    }
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}