
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/cart.dart';

abstract class ShopCartContract {
  void showMessageError(String message, BuildContext buildContext);
  void onShowProgressDialog();
  void onHideProgressDialog();
  void onGetDataSuccess();
  void onUpdateSuccess(CartItem cartItem);
  void onDeleteSuccess(CartItem cartItem);
}

class ShopCartPresenter {

  ShopCartContract _view;

  ShopCartPresenter(this._view);

  var _firebaseAuth = FirebaseAuth.instance;

  Future<List<CartItem>> getListCart() async{
    onShowProgressDialog();
    List<CartItem> listBody = new List();

    return listBody;
  }

  Future<void> updateQuantityCart(int countItem, CartItem cartItem, BuildContext context) async {
    onShowProgressDialog();

  }

  Future<void> removeFromCart(CartItem cartItem, BuildContext context) async {
    onShowProgressDialog();

  }

  onUpdateSuccess(CartItem cartItem){
    _view.onUpdateSuccess(cartItem);
  }

  onDeleteSuccess(CartItem cartItem){
    onHideProgressDialog();
    _view.onDeleteSuccess(cartItem);
  }

  onGetDataSuccess(){
    onHideProgressDialog();
    _view.onGetDataSuccess();
  }

  onShowProgressDialog(){
    _view.onShowProgressDialog();
  }

  onHideProgressDialog(){
    _view.onHideProgressDialog();
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}