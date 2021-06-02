import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginContract {
  void loginSuccess(User firebaseUser, String type);
  void backToHome();
  void goToRegister(String userId, String type);
  void onGoToRegister();
  void onBackToLogin();
  void showMessageError(String message, BuildContext buildContext);
  void onShowProgressDialog();
  void onHideProgressDialog();
}

class LoginPresenter {

  LoginContract _view;
  LoginPresenter(this._view);

  final GoogleSignIn googleSignIn = GoogleSignIn();
  var _firebaseAuth = FirebaseAuth.instance;
  static final facebookSignIn = FacebookLoginWeb();

  handleLoginGoogle(BuildContext mContext) async {
    onShowProgressDialog();
    await signInWithGoogle().then((value) {
        if(value != null){
          onLoginSuccess(value, 'google');
        }else{
          showMessageError('Error : user null', mContext);
        }
    });
  }

  handleLoginFacebook(BuildContext mContext) async {
    onShowProgressDialog();
    await loginWithFacebook().then((value) {
      if(value != null){
        onLoginSuccess(value, 'facebook');
      }else{
        showMessageError('Error : user null', mContext);
      }
    });
  }

  showMessageError(String message, BuildContext buildContext){
    onHideProgressDialog();
    _view.showMessageError(message, buildContext);
  }

  onLoginSuccess(User firebaseUser, String type){
    onHideProgressDialog();
    _view.loginSuccess(firebaseUser, type);
  }

  handleSignOut(AuthNotifier authNotifier) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await signOut().then((value) {
      authNotifier.user =  null;
      authNotifier.count = 0;
      prefs.setBool(Common.LOGIN, false);
      prefs.remove(Common.UUID);
    });
  }

  Future<String> signOut() async {
    if (_firebaseAuth.currentUser != null){
      await _firebaseAuth.signOut();
    }else{
      await facebookSignIn.logOut();
    }
    return 'User signed out';
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut().whenComplete((){
      print('okkkkkk');
    });
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    var userCredential = await _firebaseAuth.signInWithCredential(credential);
    final User user = userCredential.user;

    if (user != null) {
      var currentUser = await _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);
      return user;
    }

    return null;
  }

  Future<User> loginWithFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    if(result.status == FacebookLoginStatus.loggedIn){
      final FacebookAccessToken accessToken = result.accessToken;
      final credential = FacebookAuthProvider.credential(accessToken.token);
      final user = (await _firebaseAuth.signInWithCredential(credential)).user;
      facebookSignIn.testApi();
      return user;
    }else if (result.status == FacebookLoginStatus.cancelledByUser){
      return null;
    }else if (result.status == FacebookLoginStatus.error){
      return null;
    }else{
      return null;
    }
  }

  Future<void> registerWithEmailPassword(String email, String password, BuildContext mContext) async {
    onShowProgressDialog();
    //await Firebase.initializeApp();

    try{
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
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
        onLoginSuccess(user, 'email');
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

  Future<void> loginWithEmailAndPassword(String email, String password, BuildContext mContext) async {
    onShowProgressDialog();
    //await Firebase.initializeApp();

    try{
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
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
        onLoginSuccess(user, 'email');
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

  // Future<void> loginWithEmailLink(String email, BuildContext mContext) async {
  //   onShowProgressDialog();
  //   //await Firebase.initializeApp();
  //   var auth = FirebaseAuth.instance;
  //
  //   try{
  //     await _firebaseAuth.sendSignInWithEmailLink(
  //         email: email,
  //         url: "https://onlineshop-b08c5.firebaseapp.com/",
  //         handleCodeInApp: true,
  //         iOSBundleID: 'com.verz.shop',
  //         androidPackageName: 'com.verz.shop',
  //         androidInstallIfNotAvailable: true,
  //         androidMinimumVersion: '12'
  //     ).catchError((onError){
  //       print('Error sending email verification $onError');
  //     }).then((value) async {
  //
  //     });;
  //   }catch(_){
  //     if(_ is PlatformException) {
  //       if(_.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
  //         showMessageError('$email has already been registered', mContext);
  //       }else{
  //         showMessageError(_.message, mContext);
  //       }
  //     }else{
  //       showMessageError(_.toString(), mContext);
  //     }
  //   }
  //
  //   return null;
  // }

  onGoToRegister(){
    _view.onGoToRegister();
  }

  onBackToLogin(){
    _view.onBackToLogin();
  }

  onShowProgressDialog(){
    _view.onShowProgressDialog();
  }

  onHideProgressDialog(){
    _view.onHideProgressDialog();
  }
}