
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';

abstract class ShopCartContract {
  void showMessageError(String message, BuildContext buildContext);
  void onShowProgressDialog();
  void onHideProgressDialog();
  void onRemoveItemCart(CartItem cartItem, int index);
  void onUpdateSuccess(CartItem cartItem);
  void onDeleteSuccess(CartItem cartItem, int index);
  void onPaymentSuccess();
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

  removeFromCart(CartItem cartItem, int index) async {
    _view.onRemoveItemCart(cartItem, index);
  }

  onUpdateSuccess(CartItem cartItem, CartNotifier cartNotifier){
    cartNotifier.currentLoading = false;
    _view.onUpdateSuccess(cartItem);
  }

  onDeleteSuccess(CartItem cartItem, int index){
    onHideProgressDialog();
    _view.onDeleteSuccess(cartItem, index);
  }

  onPaymentSuccess(){
    _view.onPaymentSuccess();
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