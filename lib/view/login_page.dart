import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/presenter/login/checkout_presenter.dart';
import 'package:flutter_project/presenter/login/login_presenter.dart';
import 'package:flutter_project/values/image_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginContract {

  LoginPresenter loginPresenter;
  CheckoutPresenter checkoutPresenter;
  bool isGoToRegister = false;
  int _radioValue = 0;
  String userId = '';
  String typeLogin = '';
  String gender = 'male';

  TextEditingController phoneTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    loginPresenter = new LoginPresenter(this);
    checkoutPresenter = new CheckoutPresenter(this);
    super.initState();
  }

  Widget _entryFieldEmail() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        controller: emailTextController,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: 'Enter your email address',
            fillColor: Color(0xfff3f3f4),
            filled: true
        )
    );
  }

  Widget _entryFieldPassword() {
    return TextField(
        keyboardType: TextInputType.visiblePassword,
        controller: passwordTextController,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: 'Enter your password',
            fillColor: Color(0xfff3f3f4),
            filled: true
        )
    );
  }

  Widget _entryFieldName() {
    return TextField(
        keyboardType: TextInputType.text,
        controller: nameTextController,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: 'Enter your name',
            fillColor: Color(0xfff3f3f4),
            filled: true
        )
    );
  }

  Widget _entryFieldPhone() {
    return TextField(
        keyboardType: TextInputType.phone,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        controller: phoneTextController,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: 'Enter your phone number',
            fillColor: Color(0xfff3f3f4),
            filled: true
        )
    );
  }

  Widget _entryFieldAddress() {
    return TextField(
        keyboardType: TextInputType.streetAddress,
        controller: addressTextController,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: 'Enter your address',
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

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
          child: Row(
            children: [
              Container(
                height: itemHeight * 0.8,
                width: itemHeight * 0.8,
                child: FlutterLogo(),
              ),
              Spacer(flex: 1,),
              isGoToRegister ?
              Container(
                margin: EdgeInsets.only(right: itemWidth * 0.1),
                width: itemWidth * 0.3,
                height: itemHeight * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.pink[100]
                ),
                child: Stack(
                  children: [
                    Positioned(
                      child: InkWell(
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                              Icons.arrow_back
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
                    Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: FlutterLogo(),
                              width: itemWidth * 0.1,
                              height: itemWidth * 0.1,
                            ),
                            SizedBox(height: itemHeight * 0.03,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                              child: _entryFieldName(),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                              child: _entryFieldPhone(),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                              child: _entryFieldAddress(),
                            ),
                            SizedBox(height: itemHeight * 0.03,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                              child: Row(
                                children: [
                                  new Radio(
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text('Male'),
                                  Spacer(flex: 1,),
                                  new Radio(
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text('Female'),
                                  Spacer(flex: 1,),
                                  new Radio(
                                    value: 2,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text('Other'),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            InkWell(
                              child: Container(
                                width: itemWidth * 0.2,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text('Continue login', textAlign: TextAlign.center,),
                              ),
                              onTap: (){
                                setUserData();
                              },
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ) :
              Container(
                margin: EdgeInsets.only(right: itemWidth * 0.1),
                height: itemHeight * 0.8,
                width: itemWidth * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.pink[100]
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: FlutterLogo(),
                        width: itemWidth * 0.1,
                        height: itemWidth * 0.1,
                      ),
                      SizedBox(height: itemHeight * 0.05,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                        child: _entryFieldEmail(),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                        child: _entryFieldPassword(),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        child: Container(
                          width: itemWidth * 0.2,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text('Login', textAlign: TextAlign.center,),
                        ),
                        onTap: (){
                          loginPresenter.loginWithEmailAndPassword(emailTextController.value.text, passwordTextController.value.text, context);
                        },
                      ),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                                width: itemWidth * 0.1 - 10,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(PageImage.IC_GOOGLE, width: 20, height: 20,),
                                    SizedBox(width: 5,),
                                    Text('Google', textAlign: TextAlign.center,),
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
                                width: itemWidth * 0.1 - 10,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(PageImage.IC_FACEBOOK, width: 20, height: 20,),
                                    SizedBox(width: 5,),
                                    Text('Facebook', textAlign: TextAlign.center,),
                                  ],
                                )
                            ),
                            onTap: (){
                              loginPresenter.handleLoginFacebook(context);
                            },
                          )
                        ],
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        )
    );
  }

  void setUserData(){
    UserData userData = UserData();
    userData.id = this.userId;
    userData.gender = this.gender;
    userData.image = '';
    userData.phone = phoneTextController.value.text;
    userData.address = addressTextController.value.text;
    userData.name = nameTextController.value.text;
    userData.loginBy = this.typeLogin;
    checkoutPresenter.setUserData(userData, context);
  }

  @override
  void backToHome() {
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
  void loginSuccess(String userId, String type) {
    checkoutPresenter.checkLogin(userId, type, context);
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {
    print(message);
  }

  @override
  void onRegisterSuccess() {
    Navigator.pop(context, 'reload');
  }
}
