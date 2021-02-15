import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MenuLeftContract {
  void goToDetail(MenuLeft menuLeft);
  void showMessageError(String message, BuildContext buildContext);
}

class MenuLeftPresenter {

  MenuLeftContract _view;

  MenuLeftPresenter(this._view);

  Future<List<BodyRight>> getListBody(String doc) async{
    List<BodyRight> listBody = new List();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_PRODUCT);
    var document = ref.doc(DatabaseCollection.PRODUCTS).collection(doc);
    document.onSnapshot.listen((querySnapshot) {
      querySnapshot.docChanges().forEach((change) {
        if (change.type == "added") {
          Map<String, dynamic> a = change.doc.data();
          var item = BodyRight.fromJson(a);
          listBody.add(item);
        }
      });
    });
    return listBody;
  }

  Future<List<MenuLeft>> getListData() async{
    List<MenuLeft> listBody = new List();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_PRODUCT);
    ref.doc(DatabaseCollection.PRODUCTS).onSnapshot.forEach((element) {
      element.data().values.forEach((element) {
        listBody.add(MenuLeft(element, false));
      });
    });

    return listBody;
  }

  Future<void> checkLoginToAddToCart(BodyRight bodyRight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN);
    if(isLogin){
      //addToCart(bodyRight);
    }else{

    }
  }

  addToCart(CartItem bodyRight){
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    var doc = ref.doc('01').collection('02');
    doc.doc('01').get().then((value) {
      if(value.exists){
        Map<String, dynamic> a = value.data();
        var item = CartItem.fromJson(a);
        bodyRight.quantity = bodyRight.quantity + item.quantity;
        doc.doc('01').update(data: bodyRight.toJson());
      }else{
        doc.doc('01').set(bodyRight.toJson());
      }
    });

  }

  goToDetail(MenuLeft menuLeft) {
    _view.goToDetail(menuLeft);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}