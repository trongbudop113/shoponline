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
  void goToDetail(MenuLeft menuLeft);
  void showMessageError(String message, BuildContext buildContext);
  void showToastMessage(String message);
  void onSuccess();
}

class MenuLeftPresenter {

  MenuLeftContract _view;
  var _firebaseAuth = FirebaseAuth.instance;

  MenuLeftPresenter(this._view);

  Future<List<BodyRight>> getListBody(String doc) async{
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
    List<MenuLeft> listBody = new List();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_PRODUCT);
    ref.doc(DatabaseCollection.PRODUCTS).onSnapshot.forEach((element) {
      element.data().values.forEach((element) {
        listBody.add(MenuLeft(element, false));
        print(listBody.length);
      });
    });
    onSuccess();
    return listBody;
  }

  Future<void> checkLoginToAddToCart(CartItem bodyRight, CartPresenter cartPresenter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN);
    if(isLogin && _firebaseAuth.currentUser != null){
      addToCart(bodyRight, cartPresenter);
    }else{
      print('logiinaaaaaaaaaaaaaaaaaaaaaaa');
    }
  }

  addToCart(CartItem bodyRight, CartPresenter cartPresenter){
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    var doc = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    doc.doc(bodyRight.id).get().then((value) {
      if(value.exists){
        Map<String, dynamic> a = value.data();
        var item = CartItem.fromJson(a);
        bodyRight.quantity = bodyRight.quantity + item.quantity;
        doc.doc(bodyRight.id).update(data: bodyRight.toJson()).whenComplete(() {
          cartPresenter.onAddToCartSuccess(bodyRight);
        });
      }else{
        doc.doc(bodyRight.id).set(bodyRight.toJson()).whenComplete(() {
          cartPresenter.onAddToCartSuccess(bodyRight);
        });
      }
    });

  }

  onSuccess(){
    _view.onSuccess();
  }

  goToDetail(MenuLeft menuLeft) {
    _view.goToDetail(menuLeft);
  }

  showToastMessage(String message){
    _view.showToastMessage(message);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}