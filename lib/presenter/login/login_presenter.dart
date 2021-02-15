import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';
import 'package:flutter_project/common/common.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginContract {
  void loginSuccess(String userId, String type);
  void backToHome();
  void goToRegister(String userId, String type);
  void onRegisterSuccess();
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
          onLoginSuccess(value, 'google');
        }else{
          showMessageError('Error : user null', mContext);
        }
    });
  }

  handleLoginFacebook(BuildContext mContext) async {

    await loginWithFacebook().then((value) {
      if(value != null){
        onLoginSuccess(value, 'facebook');
      }else{
        showMessageError('Error : user null', mContext);
      }
    });
  }

  showMessageError(String message, BuildContext buildContext){
    _view.showMessageError(message, buildContext);
  }

  onLoginSuccess(String userId, String type){
    _view.loginSuccess(userId, type);
  }

  handleSignOut() async{
    await signOut().then((value) {
      print(value);
    });
  }

  Future<String> signOut() async {
    if (_firebaseAuth.currentUser != null){
      await _firebaseAuth.signOut();
    }else{
      await facebookSignIn.logOut();
    }
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

  Future<void> registerWithEmailPassword(String email, String password, BuildContext mContext) async {
    // Initialize Firebase
    await Firebase.initializeApp();

    try{
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user;
      print(user.uid);

      if (user != null) {
        assert(user.uid != null);
        assert(user.email != null);

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        onLoginSuccess(user.uid, 'email');
      }
    }catch(_){
      if(_ is PlatformException) {
        if(_.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          showMessageError('$email has already been registered', mContext);
        }else{
          showMessageError(_.message, mContext);
        }
      }else{
        showMessageError(_.toString(), mContext);
      }
    }

    return null;
  }
}