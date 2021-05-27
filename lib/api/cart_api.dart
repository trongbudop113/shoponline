import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/model/favorite.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/favorite_notifier.dart';
import 'package:flutter_project/presenter/cart/shop_cart_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

getListCartData(CartNotifier cartNotifier) async{
  cartNotifier.currentLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CART).doc(uid).collection(uid).get();

  CartTotalItem cartTotalItem = CartTotalItem();
  List<CartItem> _listCart = [];
  var totalPrice = 0.0;
  snapshot.docs.forEach((document) {
    var item = CartItem.fromMap(document.data());
    totalPrice = totalPrice + (double.parse(item.price.toString()) * item.quantity);
    _listCart.add(item);
  });
  cartTotalItem.cartItems = _listCart;
  cartTotalItem.total = totalPrice.toString();
  cartTotalItem.status = 'Create';
  cartTotalItem.code = '';
  cartTotalItem.discount = '0';
  cartTotalItem.totalFinal = totalPrice - double.parse(cartTotalItem.discount);

  //cartNotifier.cartList = _listCart;
  cartNotifier.cartTotalItem = cartTotalItem;
  cartNotifier.currentLoading = false;
}

getListFavoriteData(FavoriteNotifier favoriteNotifier) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  bool isLogin = prefs.getBool(Common.LOGIN) ?? false;
  if(isLogin){
    var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_WISH_LIST).doc(uid).collection(uid).get();

    List<FavoriteItem> _listFavorite = [];
    favoriteNotifier.favoriteCount = snapshot.docs.length;
    snapshot.docs.forEach((document) {
      var item = FavoriteItem.fromMap(document.data());
      _listFavorite.add(item);
    });
    favoriteNotifier.favoriteList = _listFavorite;
  }
}

updateQuantityCart(CartItem cartItem, int count, CartNotifier cartNotifier, ShopCartPresenter shopCartPresenter) async {
  cartNotifier.currentLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CART).doc(uid).collection(uid).doc(cartItem.id);

  cartItem.quantity = count;

  snapshot.update(cartItem.toJson()).whenComplete(() async {
    var snapshotCart = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CART).doc(uid).collection(uid).get();
    CartTotalItem cartTotalItem = CartTotalItem();
    List<CartItem> _listCart = [];
    var totalPrice = 0.0;
    snapshotCart.docs.forEach((document) {
      var item = CartItem.fromMap(document.data());
      totalPrice = totalPrice + (double.parse(item.price.toString()) * item.quantity);
      _listCart.add(item);
    });
    cartTotalItem.cartItems = _listCart;
    cartTotalItem.total = totalPrice.toString();
    cartTotalItem.status = 'Create';
    cartTotalItem.code = '';
    cartTotalItem.discount = '0';
    cartTotalItem.totalFinal = totalPrice - double.parse(cartTotalItem.discount);

    //cartNotifier.cartList = _listCart;
    cartNotifier.cartTotalItem = cartTotalItem;
    shopCartPresenter.onUpdateSuccess(cartItem, cartNotifier);
  });
}

removeItemCart(CartItem cartItem, CartNotifier cartNotifier, ShopCartPresenter shopCartPresenter, int index, BuildContext context, AuthNotifier authNotifier) async {
  cartNotifier.currentLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CART).doc(uid).collection(uid).doc(cartItem.id);

  snapshot.delete().whenComplete(() {
    getCountCart(authNotifier, cartNotifier);
    shopCartPresenter.onDeleteSuccess(cartItem, index);
  });
}

paymentCart(CartNotifier cartNotifier, AuthNotifier authNotifier, ShopCartPresenter shopCartPresenter) async {
  cartNotifier.currentLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';

  CartTotalItemPost cartTotalItemPost = CartTotalItemPost();

  var timeStamp = Timestamp.now().millisecondsSinceEpoch.toString();
  var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_REQUESTS).doc(uid).collection(uid).doc(timeStamp);

  var listItem = [];
  cartNotifier.cartTotalItem.cartItems.forEach((element) {
    listItem.add(element.toJson());
  });

  cartTotalItemPost.id = timeStamp;
  cartTotalItemPost.cartItems = listItem;
  cartTotalItemPost.totalFinal = cartNotifier.cartTotalItem.totalFinal;
  cartTotalItemPost.total = cartNotifier.cartTotalItem.total;
  cartTotalItemPost.discount = cartNotifier.cartTotalItem.discount;
  cartTotalItemPost.code = cartNotifier.cartTotalItem.code;
  cartTotalItemPost.status = 'Ordered';


  snapshot.set(cartTotalItemPost.toJson()).then((value) async {
    var snapshotCart = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CART).doc(uid).collection(uid).get();
    snapshotCart.docChanges.forEach((element) {
      element.doc.reference.delete();
    });
    getCountCart(authNotifier, cartNotifier);
    shopCartPresenter.onPaymentSuccess();;
  });
}