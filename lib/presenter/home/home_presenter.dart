import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class HomeContract {
  void goToCartDetail();
  void goToLogin();
  void goToWishList();
  void showMessageError(String message, BuildContext buildContext);
}

class HomePresenter {

  HomeContract _view;

  HomePresenter(this._view);

  final GoogleSignIn googleSignIn = GoogleSignIn();
  var _firebaseAuth = FirebaseAuth.instance;

  goToCartDetail(BuildContext mContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(Common.LOGIN) ?? false;
    if(intValue){
      _view.goToCartDetail();
    }else{
      _view.goToLogin();
    }
  }

  goToWishList(BuildContext mContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(Common.LOGIN) ?? false;
    if(intValue){
      _view.goToWishList();
    }else{
      _view.goToLogin();
      await signInWithGoogle().then((value) {
        showMessageError("Ok", mContext);
      });
    }
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }

  Future<String> signInWithGoogle() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    final User user = userCredential.user;

    if (user != null) {
      // Checking if email and name is null
      assert(user.uid != null);
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);

      return 'Google sign in successful, User UID: ${user.uid}';
    }

    return null;
  }
}