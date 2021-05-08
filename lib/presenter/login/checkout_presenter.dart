
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/presenter/login/login_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPresenter {

  LoginContract _view;

  CheckoutPresenter(this._view);

  Future<void> checkLogin(FirebaseUser firebaseUser, String type, BuildContext mContext, AuthNotifier authNotifier) async{
    try{
      var snapshot = Firestore.instance.collection(DatabaseCollection.ALL_USER).document(firebaseUser.uid);

      snapshot.get().then((value) {
        if(value.exists){
          authNotifier.user = firebaseUser;
          backToHome(firebaseUser.uid);
        }else{
          goToRegister(firebaseUser.uid, type);
        }
      });
    }catch(e){
      showMessageError(e.toString(), mContext);
    }
  }

  setUserData(UserData userData, BuildContext mContext){
    try{
      var snapshot = Firestore.instance.collection(DatabaseCollection.ALL_USER);
      var document = snapshot.document(userData.id);
      document.setData(userData.toJson()).whenComplete(() => backToHome(userData.id));
    }catch(e){
      showMessageError(e.toString(), mContext);
    }
  }

  backToHome(String uuid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Common.LOGIN, true);
    prefs.setString(Common.UUID, uuid);
    _view.backToHome();
  }

  goToRegister(String userId, String type){
    _view.goToRegister(userId, type);
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }
}