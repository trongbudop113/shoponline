import 'package:flutter_project/model/cart.dart';

abstract class CartContract {
  void onAddToCartSuccess(CartItem bodyRight);
  void onAddToWishListSuccess(CartItem bodyRight);
  void onAddToWishListExist(String message);
}

class CartPresenter {

  CartContract _view;

  CartPresenter(this._view);

  onAddToCartSuccess(CartItem bodyRight) {
    _view.onAddToCartSuccess(bodyRight);
  }

  onAddToWishListSuccess(CartItem bodyRight) {
    _view.onAddToWishListSuccess(bodyRight);
  }

  onAddToWishListExist(String message) {
    _view.onAddToWishListExist(message);
  }
}