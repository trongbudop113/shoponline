import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/presenter/login/login_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPresenter {

  LoginContract _view;

  CheckoutPresenter(this._view);

  Future<void> checkLogin(String userId, String type, BuildContext mContext) async{

    try{
      fs.Firestore store = firestore();
      fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_USER);
      var document = ref.doc(userId);
      document.get().then((value) {
        if(value.exists){
          backToHome();
        }else{
          goToRegister(userId, type);
        }
      });
    }catch(e){
      showMessageError(e.toString(), mContext);
    }
  }

  setUserData(UserData userData, BuildContext mContext){
    try{
      fs.Firestore store = firestore();
      fs.CollectionReference ref = store.collection(DatabaseCollection.ALL_USER);
      var document = ref.doc(userData.id);
      document.set(userData.toJson()).whenComplete(() => backToHome());
    }catch(e){
      showMessageError(e.toString(), mContext);
    }
  }

  backToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Common.LOGIN, true);
    _view.backToHome();
  }

  goToRegister(String userId, String type){
    _view.goToRegister(userId, type);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}