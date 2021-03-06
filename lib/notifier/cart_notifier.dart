import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/cart.dart';

class CartNotifier with ChangeNotifier {
  List<CartItem> _cartList = [];
  CartItem _currentItemCart;
  CartTotalItem _cartTotalItem;
  bool _isLoading = false;

  UnmodifiableListView<CartItem> get cartList => UnmodifiableListView(_cartList);

  CartItem get currentItemCart => _currentItemCart;
  CartTotalItem get cartTotalItem => _cartTotalItem;
  bool get currentLoading => _isLoading;

  set cartList(List<CartItem> cartList) {
    _cartList = cartList;
    notifyListeners();
  }

  set cartTotalItem(CartTotalItem cartTotalItem){
    _cartTotalItem = cartTotalItem;
    notifyListeners();
  }

  set currentLoading(bool isLoad) {
    _isLoading = isLoad;
    notifyListeners();
  }

  set currentItemCart(CartItem cartItem) {
    _currentItemCart = cartItem;
    notifyListeners();
  }
}
