
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class MenuLeftContract {
  void goToDetail();
  void showMessageError(String message, BuildContext buildContext);
  void onSuccess();
  void onShowProgressDialog();
  void onHideProgressDialog();
}

class MenuLeftPresenter {

  MenuLeftContract _view;
  var _firebaseAuth = FirebaseAuth.instance;

  MenuLeftPresenter(this._view);

  onSuccess(){
    _view.onSuccess();
    onHideProgressDialog();
  }

  onShowProgressDialog(){
    _view.onShowProgressDialog();
  }

  onHideProgressDialog(){
    _view.onHideProgressDialog();
  }

  goToDetail() {
    _view.goToDetail();
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}