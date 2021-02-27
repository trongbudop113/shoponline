import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;

abstract class HomeContract {
  void goToCartDetail();
  void goToLogin();
  void goToWishList();
  void goToPerson();
  void showMessageError(String message, BuildContext buildContext);
}

class HomePresenter {

  HomeContract _view;

  HomePresenter(this._view);

  var _firebaseAuth = FirebaseAuth.instance;

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

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}