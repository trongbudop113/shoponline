import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/presenter/cart/shop_cart_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

getListCartData(CartNotifier cartNotifier) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await Firestore.instance.collection(DatabaseCollection.ALL_CART).document(uid).collection(uid).getDocuments();

  List<CartItem> _listCart = [];

  snapshot.documents.forEach((document) {
    var item = CartItem.fromMap(document.data);
    _listCart.add(item);
  });
  cartNotifier.cartList = _listCart;
}

updateQuantityCart(CartItem cartItem, int count, CartNotifier cartNotifier, ShopCartPresenter shopCartPresenter) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await Firestore.instance.collection(DatabaseCollection.ALL_CART).document(uid).collection(uid).document(cartItem.id);
  var snapshotCart = await Firestore.instance.collection(DatabaseCollection.ALL_CART).document(uid).collection(uid).getDocuments();

  cartItem.quantity = count;

  snapshot.updateData(cartItem.toJson()).whenComplete(() {
    List<CartItem> _listCart = [];
    snapshotCart.documents.forEach((document) {
      var item = CartItem.fromMap(document.data);
      _listCart.add(item);
    });
    cartNotifier.cartList = _listCart;
    shopCartPresenter.onUpdateSuccess(cartItem);
  });
}

removeItemCart(CartItem cartItem, CartNotifier cartNotifier, ShopCartPresenter shopCartPresenter, int index, BuildContext context, AuthNotifier authNotifier) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await Firestore.instance.collection(DatabaseCollection.ALL_CART).document(uid).collection(uid).document(cartItem.id);
  var snapshotCart = await Firestore.instance.collection(DatabaseCollection.ALL_CART).document(uid).collection(uid).getDocuments();

  snapshot.delete().whenComplete(() {
    getCountCart(authNotifier, cartNotifier);
    shopCartPresenter.onDeleteSuccess(cartItem, index);
  });
}