import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartContract {
  void onAddToCartSuccess(CartItem bodyRight);
  void onAddToWishListSuccess(BodyRight bodyRight);
  void onAddToWishListExist(String message);
  void actionAddToCart();
  void actionAddToWishList();
  void showDialogLogin(String message);
}

class CartPresenter {

  CartContract _view;

  CartPresenter(this._view);

  Future<void> checkLoginToAddToWishList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if(isLogin){
      _view.actionAddToWishList();
    }else{
      _view.showDialogLogin('aaaaaaaaa');
    }
  }

  Future<void> checkLoginToAddToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if(isLogin){
      _view.actionAddToCart();
    }else{
      _view.showDialogLogin('aaaaaaaaa');
    }
  }

  onAddToCartSuccess(CartItem bodyRight) {
    _view.onAddToCartSuccess(bodyRight);
  }

  onAddToWishListSuccess(BodyRight bodyRight) {
    _view.onAddToWishListSuccess(bodyRight);
  }

  onAddToWishListExist(String message) {
    _view.onAddToWishListExist(message);
  }
}