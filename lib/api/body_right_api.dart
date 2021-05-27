
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/api/cart_api.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/favorite_notifier.dart';
import 'package:flutter_project/presenter/home/cart_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

addToCart(AuthNotifier authNotifier, BodyRightNotifier bodyRightNotifier, int count, CartPresenter cartPresenter, CartNotifier cartNotifier) async{
  cartNotifier.currentLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CART).doc(uid).collection(uid);

  CartItem cart = new CartItem();
  cart.quantity = count;
  cart.id = bodyRightNotifier.currentProduct.id;
  cart.name = bodyRightNotifier.currentProduct.name;
  cart.image = bodyRightNotifier.currentProduct.image;
  cart.discount = bodyRightNotifier.currentProduct.discount;
  cart.price = bodyRightNotifier.currentProduct.price;

  snapshot.doc(bodyRightNotifier.currentProduct.id).get().then((value) {
    if(value.exists){
      Map<String, dynamic> a = value.data();
      var item = CartItem.fromJson(a);

      cart.quantity = cart.quantity + item.quantity;
      snapshot.doc(bodyRightNotifier.currentProduct.id).update(cart.toJson()).whenComplete(() {
        cartPresenter.onAddToCartSuccess(cart);
      });
    }else{
      snapshot.doc(bodyRightNotifier.currentProduct.id).set(cart.toJson()).whenComplete(() {
        cartPresenter.onAddToCartSuccess(cart);
        getCountCart(authNotifier, cartNotifier);
      });
    }
  });

}

addToWishList(AuthNotifier authNotifier, BodyRightNotifier bodyRightNotifier, int count, CartPresenter cartPresenter, FavoriteNotifier favoriteNotifier) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_WISH_LIST).doc(uid).collection(uid);


  snapshot.doc(bodyRightNotifier.currentProduct.id).get().then((value) {
    if(value.exists){
      cartPresenter.onAddToWishListExist(bodyRightNotifier.currentProduct.name + ' is existed in your list');
    }else{
      snapshot.doc(bodyRightNotifier.currentProduct.id).set(bodyRightNotifier.currentProduct.toMap()).whenComplete(() {
        cartPresenter.onAddToWishListSuccess(bodyRightNotifier.currentProduct);
        getListFavoriteData(favoriteNotifier);
      });
    }
  });

}