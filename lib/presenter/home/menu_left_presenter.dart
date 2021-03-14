import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/presenter/home/cart_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MenuLeftContract {
  void goToDetail(BodyRight bodyRight);
  void showMessageError(String message, BuildContext buildContext);
  void showToastMessage(String message);
  void onSuccess();
  void onShowProgressDialog();
  void onHideProgressDialog();
}

class MenuLeftPresenter {

  MenuLeftContract _view;
  var _firebaseAuth = FirebaseAuth.instance;

  MenuLeftPresenter(this._view);

  Future<List<BodyRight>> getListBody(String doc) async{
    onShowProgressDialog();
    List<BodyRight> listBody = new List();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_PRODUCT);
    var document = ref.doc(DatabaseCollection.PRODUCTS).collection(doc).limit(4);
    document.onSnapshot.listen((querySnapshot) {
      querySnapshot.docChanges().forEach((change) {
        if (change.type == "added") {
          Map<String, dynamic> a = change.doc.data();
          var item = BodyRight.fromJson(a);
          listBody.add(item);
        }
      });
    });
    onSuccess();
    return listBody;
  }

  Future<List<MenuLeft>> getListData() async{
    onShowProgressDialog();
    List<MenuLeft> listBody = new List();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_PRODUCT);
    ref.doc(DatabaseCollection.PRODUCTS).onSnapshot.forEach((element) {
      element.data().values.forEach((element) {
        listBody.add(MenuLeft(element, false));
      });
    });
    onSuccess();
    return listBody;
  }

  Future<void> checkLoginToAddToCart(CartItem bodyRight, CartPresenter cartPresenter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if(isLogin && _firebaseAuth.currentUser != null){
      addToCart(bodyRight, cartPresenter);
    }else{
      print('logiinaaaaaaaaaaaaaaaaaaaaaaa');
    }
  }

  Future<void> checkLoginToAddToWishList(CartItem bodyRight, CartPresenter cartPresenter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if(isLogin && _firebaseAuth.currentUser != null){
      addToWishList(bodyRight, cartPresenter);
    }else{
      print('logiinaaaaaaaaaaaaaaaaaaaaaaa');
    }
  }

  addToWishList(CartItem bodyRight, CartPresenter cartPresenter){
    onShowProgressDialog();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_WISH_LIST);
    var doc = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    doc.doc(bodyRight.id).get().then((value) {
      if(value.exists){
        onHideProgressDialog();
        cartPresenter.onAddToWishListExist(bodyRight.name + ' is existed in your list');
      }else{
        doc.doc(bodyRight.id).set(bodyRight.toJson()).whenComplete(() {
          onHideProgressDialog();
          cartPresenter.onAddToWishListSuccess(bodyRight);
        });
      }
    });

  }

  addToCart(CartItem bodyRight, CartPresenter cartPresenter){
    onShowProgressDialog();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    var doc = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    doc.doc(bodyRight.id).get().then((value) {
      if(value.exists){
        Map<String, dynamic> a = value.data();
        var item = CartItem.fromJson(a);
        bodyRight.quantity = bodyRight.quantity + item.quantity;
        doc.doc(bodyRight.id).update(data: bodyRight.toJson()).whenComplete(() {
          onHideProgressDialog();
          cartPresenter.onAddToCartSuccess(bodyRight);
        });
      }else{
        doc.doc(bodyRight.id).set(bodyRight.toJson()).whenComplete(() {
          onHideProgressDialog();
          cartPresenter.onAddToCartSuccess(bodyRight);
        });
      }
    });

  }

  onSuccess(){
    _view.onSuccess();
    onHideProgressDialog();
  }

  onShowProgressDialog(){
    _view.onShowProgressDialog();
  }

  onHideProgressDialog(){
    _view.onHideProgressDialog();
  }

  goToDetail(BodyRight bodyRight) {
    _view.goToDetail(bodyRight);
  }

  showToastMessage(String message){
    _view.showToastMessage(message);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}