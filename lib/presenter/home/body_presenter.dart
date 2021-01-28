import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;

abstract class BodyContract {
  void goToDetail(BodyRight bodyRight);
  void showMessageError(String message, BuildContext buildContext);
}

class BodyPresenter {

  BodyContract _view;

  BodyPresenter(this._view);

  Future<List<BodyRight>> getListData(String doc) async{
    List<BodyRight> listBody = new List();
    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection("all_product");
    var document = ref.doc('products').collection(doc);
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

  goToDetail(BodyRight bodyRight) {
    _view.goToDetail(bodyRight);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}