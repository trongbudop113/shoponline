import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/cart.dart';

abstract class ShopCartContract {
  void showMessageError(String message, BuildContext buildContext);
  void onShowProgressDialog();
  void onHideProgressDialog();
  void onGetDataSuccess();
  void onUpdateSuccess(CartItem cartItem);
  void onDeleteSuccess();
}

class ShopCartPresenter {

  ShopCartContract _view;

  ShopCartPresenter(this._view);

  var _firebaseAuth = FirebaseAuth.instance;

  Future<List<CartItem>> getListCart() async{
    onShowProgressDialog();
    List<CartItem> listBody = new List();
    Firestore store = firestore();
    CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    var document = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    document.onSnapshot.listen((querySnapshot) {
      querySnapshot.docChanges().forEach((change) {
        if (change.type == "added") {
          Map<String, dynamic> a = change.doc.data();
          var item = CartItem.fromJson(a);
          print(item.name);
          listBody.add(item);
        }
      });
    });
    onGetDataSuccess();
    return listBody;
  }

  Future<void> updateQuantityCart(int countItem, CartItem cartItem, BuildContext context) async {
    onShowProgressDialog();
    Firestore store = firestore();
    CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    var doc = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    cartItem.quantity = countItem;
    doc.doc(cartItem.id).get().then((value) {
      doc.doc(cartItem.id).set(cartItem.toJson()).whenComplete(() {
        onHideProgressDialog();
        onUpdateSuccess(cartItem);
      }).catchError((e){
        showMessageError(e.toString(), context);
      });
    });
  }

  Future<void> removeFromCart(CartItem cartItem, BuildContext context) async {
    onShowProgressDialog();
    Firestore store = firestore();
    CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    var doc = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    doc.doc(cartItem.id).delete().whenComplete(() {
      onDeleteSuccess();
    }).catchError((e){
      showMessageError(e.toString(), context);
    });
  }

  onUpdateSuccess(CartItem cartItem){
    _view.onUpdateSuccess(cartItem);
  }

  onDeleteSuccess(){
    onHideProgressDialog();
    _view.onDeleteSuccess();
  }

  onGetDataSuccess(){
    onHideProgressDialog();
    _view.onGetDataSuccess();
  }

  onShowProgressDialog(){
    _view.onShowProgressDialog();
  }

  onHideProgressDialog(){
    _view.onHideProgressDialog();
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}