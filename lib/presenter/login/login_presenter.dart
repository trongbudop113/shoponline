import 'package:flutter/cupertino.dart';
import 'package:flutter_project/network/api_provider.dart';

abstract class LoginContract {
  void goToNextScreen();
  void showMessageError(String message, BuildContext buildContext);
}

class LoginPresenter {

  LoginContract _view;
  ApiProvider _provider = ApiProvider();

  goToNextScreen(){
    _view.goToNextScreen();
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}