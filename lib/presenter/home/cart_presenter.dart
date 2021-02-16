import 'package:flutter_project/model/cart.dart';

abstract class CartContract {
  void onAddToCartSuccess(CartItem bodyRight);
}

class CartPresenter {

  CartContract _view;

  CartPresenter(this._view);

  onAddToCartSuccess(CartItem bodyRight) {
    _view.onAddToCartSuccess(bodyRight);
  }
}