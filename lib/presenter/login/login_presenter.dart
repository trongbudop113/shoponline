import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';
import 'package:flutter_project/common/common.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginContract {
  void loginSuccess(String userId);
  void backToHome();
  void goToRegister();
  void showMessageError(String message, BuildContext buildContext);
}

class LoginPresenter {

  LoginContract _view;
  LoginPresenter(this._view);

  final GoogleSignIn googleSignIn = GoogleSignIn();
  var _firebaseAuth = FirebaseAuth.instance;
  static final facebookSignIn = FacebookLoginWeb();

  handleLoginGoogle(BuildContext mContext) async {

    await signInWithGoogle().then((value) {
        if(value != null){
          onLoginSuccess(value);
        }else{
          showMessageError('Error : user null', mContext);
        }
    });
  }

  handleLoginFacebook(BuildContext mContext) async {

    await loginWithFacebook().then((value) {
      if(value != null){
        onLoginSuccess(value);
      }else{
        showMessageError('Error : user null', mContext);
      }
    });
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }

  onLoginSuccess(String userId){
    _view.loginSuccess(userId);
  }

  handleSignOut() async{
    await signOut().then((value) {
      print(value);
    });
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Common.LOGIN, false);
    return 'User signed out';
  }

  Future<String> signInWithGoogle() async {
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
      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);
      return user.uid;
    }

    return null;
  }

  Future<String> loginWithFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    if(result.status == FacebookLoginStatus.loggedIn){
      final FacebookAccessToken accessToken = result.accessToken;
      facebookSignIn.testApi();
      return accessToken.userId;
    }else if (result.status == FacebookLoginStatus.cancelledByUser){
      return null;
    }else if (result.status == FacebookLoginStatus.error){
      return null;
    }else{
      return null;
    }
  }
}