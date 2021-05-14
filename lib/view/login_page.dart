import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/api/cart_api.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/hide_keyboard.dart';
import 'package:flutter_project/dialog/progress_dialog.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/favorite_notifier.dart';
import 'package:flutter_project/presenter/login/checkout_presenter.dart';
import 'package:flutter_project/presenter/login/login_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/values/image_page.dart';
import 'package:flutter_project/view/app_bar_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with KeyboardHiderMixin implements LoginContract {

  LoginPresenter loginPresenter;
  CheckoutPresenter checkoutPresenter;
  bool isGoToRegister = false;
  int _radioValue = 0;
  String userId = '';
  String typeLogin = '';
  String gender = 'male';
  double heightAppbar = 0.0;

  bool _isShow = false;

  TextEditingController phoneTextController = TextEditingController();
  TextEditingController birthDayTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController streetTextController = TextEditingController();
  TextEditingController villageTextController = TextEditingController();
  TextEditingController wardTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  var textStyle = GoogleFonts.bungee(fontSize: 10);
  var textStyleText = GoogleFonts.bungee(fontSize: 15);

  @override
  void initState() {
    loginPresenter = new LoginPresenter(this);
    checkoutPresenter = new CheckoutPresenter(this);
    loadHeightAppbar();
    super.initState();
  }

  void loadHeightAppbar(){
    if (kIsWeb) {
      heightAppbar = 60.0;
    } else {
      heightAppbar = 85.0;
    }
  }

  Widget _entryFieldText(TextEditingController textController, bool isPass, TextInputType inputType, String hint) {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        controller: textController,
        obscuringCharacter: "*",
        obscureText: isPass,
        style: textStyle,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: hint,
            hintStyle: textStyle,
            fillColor: Color(0xfff3f3f4),
            filled: true
        )
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          gender = 'male';
        break;
        case 1:
          gender = 'female';
        break;
        case 2:
          gender = 'other';
        break;
      }
      });
  }

  FocusScopeNode currentFocus;
  void clearFocus(){
    hideKeyboard();
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    var itemWidthRight = MediaQuery.of(context).size.width * (!Common.isPortrait(context) ? 0.4 : 0.8);

    return GestureDetector(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBarNormal(heightAppbar: heightAppbar),
          body: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !Common.isPortrait(context) ? Container(
                  height: itemHeight * 0.85,
                  width: itemWidth * 0.5,
                  child: Image.asset(PageImage.LOGO_BLACK),
                ) : Container(),
                !Common.isPortrait(context) ? Spacer(flex: 1,) : Container(),
                isGoToRegister ?
                Container(
                  margin: EdgeInsets.only(right: itemWidth * 0.05, left: itemWidth * 0.05),
                  width: itemWidthRight,
                  height: itemHeight * 0.85,
                  color: BLACK,
                  child: Stack(
                    children: [
                      Positioned(
                        child: InkWell(
                          focusColor: WHITE,
                          hoverColor: WHITE,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.arrow_back,
                              color: WHITE,
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              isGoToRegister = false;
                            });
                          },
                        ),
                        left: itemWidth * 0.01,
                        top: itemWidth * 0.01,
                      ),
                      CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: itemHeight * 0.1),
                                Container(
                                  child: Image.asset(PageImage.LOGO_WHITE),
                                  width: itemWidth * (!Common.isPortrait(context) ? 0.1 : 0.32),
                                  height: itemWidth * (!Common.isPortrait(context) ? 0.1 : 0.32),
                                ),
                                SizedBox(height: itemHeight * 0.03,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                                  child: _entryFieldText(nameTextController, false, TextInputType.text, 'Nhập tên đầy đủ của bạn'),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                                  child: _entryFieldText(phoneTextController, false, TextInputType.phone, 'Nhập số điện thoại của bạn'),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                                  child: _entryFieldText(birthDayTextController, false, TextInputType.phone, 'Nhập ngày sinh của bạn'),
                                ),
                                SizedBox(height: itemHeight * 0.03,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                                  child: Row(
                                    children: [
                                      new Radio(
                                        value: 0,
                                        activeColor: WHITE,
                                        groupValue: _radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      textView('Male', WHITE, 14, FontWeight.normal),
                                      Spacer(flex: 1,),
                                      new Radio(
                                        value: 1,
                                        groupValue: _radioValue,
                                        activeColor: WHITE,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      textView('Female', WHITE, 14, FontWeight.normal),
                                      Spacer(flex: 1,),
                                      new Radio(
                                        value: 2,
                                        groupValue: _radioValue,
                                        activeColor: WHITE,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      textView('Other', WHITE, 14, FontWeight.normal),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: itemWidth * 0.05),
                                      width: itemWidth * 0.3,
                                      child: _entryFieldText(streetTextController, false, TextInputType.streetAddress, 'Số nhà, tên đường'),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      margin: EdgeInsets.only(right: itemWidth * 0.05),
                                      width: itemWidth * 0.35,
                                      child: _entryFieldText(villageTextController, false, TextInputType.streetAddress, 'Phường/Xã'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: itemWidth * 0.05),
                                      width: itemWidth * 0.3,
                                      child: _entryFieldText(wardTextController, false, TextInputType.streetAddress, 'Quận/Huyện'),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      margin: EdgeInsets.only(right: itemWidth * 0.05),
                                      width: itemWidth * 0.35,
                                      child: _entryFieldText(cityTextController, false, TextInputType.streetAddress, 'Tỉnh/Thành Phố'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: itemHeight * 0.05),
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: itemWidth * (!Common.isPortrait(context) ? 0.2 : 0.7),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    color: WHITE,
                                    child: textView('Login', BLACK, 16, FontWeight.normal),
                                  ),
                                  onTap: (){
                                    setUserData();
                                  },
                                ),
                                SizedBox(height: itemHeight * 0.1),
                              ],
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: _isShow ? IndicatorProgress() : Container(),
                      )
                    ],
                  ),
                ) :
                Container(
                    margin: EdgeInsets.only(right: itemWidth * 0.05, left: itemWidth * 0.05),
                    alignment: Alignment.center,
                    height: itemHeight * 0.85,
                    width: itemWidthRight,
                    color: BLACK,
                    child: Stack(
                      children: [
                        CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: itemHeight * 0.1),
                                    Container(
                                      child: Image.asset(PageImage.LOGO_WHITE),
                                      width: itemWidth * (!Common.isPortrait(context) ? 0.1 : 0.32),
                                      height: itemWidth * (!Common.isPortrait(context) ? 0.1 : 0.32),
                                    ),
                                    SizedBox(height: itemHeight * 0.05,),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                                      child: _entryFieldText(emailTextController, false, TextInputType.emailAddress, 'Enter your email address'),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                                      child: _entryFieldText(passwordTextController, true, TextInputType.text, 'Enter your password'),
                                    ),
                                    Container(
                                      height: itemHeight * 0.08,
                                      alignment:  Alignment.center,
                                      margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                                      child: GestureDetector(
                                        child: textView('SignUp here', WHITE, 15, FontWeight.normal),
                                        onTap: (){
                                          loginPresenter.onGoToRegister();
                                        },
                                      )
                                    ),
                                    InkWell(
                                      child: Container(
                                        width: itemWidth * (!Common.isPortrait(context) ? 0.2 : 0.7),
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                        color: WHITE,
                                        child: Text('Login', textAlign: TextAlign.center, style: textStyleText),
                                      ),
                                      onTap: (){
                                        loginPresenter.loginWithEmailAndPassword(emailTextController.value.text, passwordTextController.value.text, context);
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Container(
                                              width: itemWidth * (!Common.isPortrait(context) ? 0.1 : 0.35) - 10,
                                              padding: EdgeInsets.symmetric(vertical: 15),
                                              color: WHITE,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(PageImage.IC_GOOGLE, width: 20, height: 20,),
                                                  SizedBox(width: 5,),
                                                  Text('Google', textAlign: TextAlign.center, style: textStyleText),
                                                ],
                                              )
                                          ),
                                          onTap: (){
                                            loginPresenter.handleLoginGoogle(context);
                                          },
                                        ),
                                        SizedBox(width: 20,),
                                        InkWell(
                                          child: Container(
                                              width: itemWidth * (!Common.isPortrait(context) ? 0.1 : 0.35) - 10,
                                              padding: EdgeInsets.symmetric(vertical: 15),
                                              color: WHITE,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(PageImage.IC_FACEBOOK, width: 20, height: 20,),
                                                  SizedBox(width: 5,),
                                                  Text('Facebook', textAlign: TextAlign.center, style: textStyleText),
                                                ],
                                              )
                                          ),
                                          onTap: (){
                                            loginPresenter.handleLoginFacebook(context);
                                          },
                                        ),
                                        SizedBox(height: itemHeight * 0.1),
                                      ],
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                        Center(
                          child: _isShow ? IndicatorProgress() : Container(),
                        )
                      ],
                    )
                )
              ],
            ),
          )
      ),
      onTap: (){
        clearFocus();
      },
    );
  }

  void setUserData(){
    UserData userData = UserData();
    userData.id = this.userId;
    userData.gender = this.gender;
    userData.image = '';
    userData.phone = phoneTextController.value.text;
    userData.birthDay = birthDayTextController.value.text;
    userData.address = '${streetTextController.text}, ${villageTextController.text}, ${wardTextController.text}, ${cityTextController.text}';
    userData.name = nameTextController.value.text;
    userData.loginBy = this.typeLogin;
    checkoutPresenter.setUserData(userData, context);
  }

  @override
  void backToHome() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    FavoriteNotifier favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: false);
    getCountCart(authNotifier, cartNotifier);
    getListFavoriteData(favoriteNotifier);

    Navigator.pop(context, 'reload');
  }

  @override
  void goToRegister(String userId, String type) {
    setState(() {
      isGoToRegister = true;
      this.userId = userId;
      this.typeLogin = type;
    });
  }

  @override
  void loginSuccess(FirebaseUser firebaseUser, String type) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    checkoutPresenter.checkLogin(firebaseUser, type, context, authNotifier);
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {
    print(message);
  }

  @override
  void onHideProgressDialog() {
    setState(() {
      _isShow = false;
    });
  }

  @override
  void onShowProgressDialog() {
    setState(() {
      _isShow = true;
    });
  }

  @override
  void onGoToRegister() {

  }
}
