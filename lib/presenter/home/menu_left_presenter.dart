import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter_project/model/menu_left.dart';

abstract class MenuLeftContract {
  void goToDetail(MenuLeft menuLeft);
  void showMessageError(String message, BuildContext buildContext);
}

class MenuLeftPresenter {

  MenuLeftContract _view;

  MenuLeftPresenter(this._view);

  Future<List<MenuLeft>> getListData() async{
    List<MenuLeft> listBody = new List();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection("all_product");
    ref.doc('products').onSnapshot.forEach((element) {
      element.data().values.forEach((element) {
        listBody.add(MenuLeft(element, false));
      });
    });

    return listBody;
  }

  goToDetail(MenuLeft menuLeft) {
    _view.goToDetail(menuLeft);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}