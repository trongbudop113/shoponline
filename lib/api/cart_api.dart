import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

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