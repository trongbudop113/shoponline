
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/favorite.dart';

abstract class FavoriteContract {
  void showMessageError(String message, BuildContext buildContext);
  void onShowProgressDialog();
  void onHideProgressDialog();
  void onGetDataSuccess();
  void onUpdateSuccess(FavoriteItem favoriteItem);
  void onDeleteSuccess();
}

class FavoritePresenter {

  FavoriteContract _view;

  FavoritePresenter(this._view);

  var _firebaseAuth = FirebaseAuth.instance;

  Future<List<FavoriteItem>> getListCart() async{
    onShowProgressDialog();
    List<FavoriteItem> listBody = new List();
    // Firestore store = firestore();
    // CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    // var document = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    // document.onSnapshot.listen((querySnapshot) {
    //   querySnapshot.docChanges().forEach((change) {
    //     if (change.type == "added") {
    //       Map<String, dynamic> a = change.doc.data();
    //       var item = FavoriteItem.fromJson(a);
    //       print(item.name);
    //       listBody.add(item);
    //     }
    //   });
    // });
    // onGetDataSuccess();
    return listBody;
  }

  Future<void> updateQuantityCart(int countItem, FavoriteItem cartItem, BuildContext context) async {
    onShowProgressDialog();
    // Firestore store = firestore();
    // CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    // var doc = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    // cartItem.quantity = countItem;
    // doc.doc(cartItem.id).get().then((value) {
    //   doc.doc(cartItem.id).set(cartItem.toJson()).whenComplete(() {
    //     onHideProgressDialog();
    //     onUpdateSuccess(cartItem);
    //   }).catchError((e){
    //     showMessageError(e.toString(), context);
    //   });
    // });
  }

  Future<void> removeFromCart(FavoriteItem cartItem, BuildContext context) async {
    onShowProgressDialog();
    // Firestore store = firestore();
    // CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    // var doc = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    // doc.doc(cartItem.id).delete().whenComplete(() {
    //   onDeleteSuccess();
    // }).catchError((e){
    //   showMessageError(e.toString(), context);
    // });
  }

  onUpdateSuccess(FavoriteItem cartItem){
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