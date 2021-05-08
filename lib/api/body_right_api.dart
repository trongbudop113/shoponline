
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

addToCart(AuthNotifier authNotifier, BodyRightNotifier bodyRightNotifier, int count) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString(Common.UUID) ?? '';
  var snapshot = await Firestore.instance.collection(DatabaseCollection.ALL_CART).document(uid).collection(uid);

  CartItem cart = new CartItem();
  cart.quantity = count;
  cart.id = bodyRightNotifier.currentProduct.id;
  cart.name = bodyRightNotifier.currentProduct.name;
  cart.image = bodyRightNotifier.currentProduct.image;
  cart.discount = bodyRightNotifier.currentProduct.discount;
  cart.price = bodyRightNotifier.currentProduct.price;

  snapshot.document(bodyRightNotifier.currentProduct.id).get().then((value) {
    if(value.exists){
      Map<String, dynamic> a = value.data;
      var item = CartItem.fromJson(a);

      cart.quantity = cart.quantity + item.quantity;
      snapshot.document(bodyRightNotifier.currentProduct.id).updateData(cart.toJson()).whenComplete(() {
        //cartPresenter.onAddToCartSuccess(cart);
        getCountCart(authNotifier);
      });
    }else{
      snapshot.document(bodyRightNotifier.currentProduct.id).setData(cart.toJson()).whenComplete(() {
        //cartPresenter.onAddToCartSuccess(cart);
        getCountCart(authNotifier);
      });
    }
  });

}