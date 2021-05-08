import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeContract {
  void goToCartDetail();
  void goToLogin();
  void goToWishList();
  void goToPerson();
  void goToDetail();
  void showToastMessage(String message);
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

  goToPersonInformation(BuildContext mContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(Common.LOGIN) ?? false;
    if(intValue){
      _view.goToPerson();
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

  goToDetail() {
    _view.goToDetail();
  }

  showToastMessage(String message){
    _view.showToastMessage(message);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}