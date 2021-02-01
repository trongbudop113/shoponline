import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/presenter/login/checkout_presenter.dart';
import 'package:flutter_project/presenter/login/login_presenter.dart';
import 'package:flutter_project/values/image_page.dart';
import 'package:flutter_project/view/home/banner_page.dart';
import 'package:flutter_project/view/home/body_page.dart';
import 'package:flutter_project/view/home/footer_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginContract {

  LoginPresenter loginPresenter;
  CheckoutPresenter checkoutPresenter;

  @override
  void initState() {
    loginPresenter = new LoginPresenter(this);
    checkoutPresenter = new CheckoutPresenter(this);
    super.initState();
  }

  Widget _entryFieldPhone() {
    return TextField(
        keyboardType: TextInputType.phone,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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

  Widget _entryFieldPassword() {
    return TextField(
        keyboardType: TextInputType.visiblePassword,
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
                        child: _entryFieldPhone(),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                        child: _entryFieldPassword(),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: itemWidth * 0.2,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text('Login', textAlign: TextAlign.center,),
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

  @override
  void backToHome() {
    Navigator.pop(context, 'reload');
  }

  @override
  void goToRegister() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
  }

  @override
  void loginSuccess(String userId) {
    checkoutPresenter.checkLogin(userId, context);
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {

  }
}
