
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderPage extends StatefulWidget {
  HeaderPage({Key key, this.title, this.homePresenter}) : super(key: key);
  final String title;
  final HomePresenter homePresenter;

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {

  var _firebaseAuth = FirebaseAuth.instance;

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Common.LOGIN) ?? false;
    if (isLogin && _firebaseAuth.currentUser != null){

    }
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = !Common.isPortrait(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeight = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;
    var sizeTextCustom = (itemHeight * 0.05) > 30 ? 30 : (itemHeight * 0.05);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: itemWidth * 0.02),
      color: BLACK,
      child: Row(
        children: [
          Container(
            child: textView('WEARISM', WHITE, sizeTextCustom, FontWeight.bold),
          ),
          Spacer(flex: 1,),
          InkWell(
            onTap: (){
              widget.homePresenter.goToWishList(context);
            },
            focusColor: Colors.white,
            hoverColor: Colors.white,
            child: Container(
              width: 50,
              height: 50,
              child: Icon(Icons.favorite, size: 30, color: WHITE),
            ),
          ),
          SizedBox(width: 20,),
          InkWell(
            onTap: (){

            },
            focusColor: Colors.grey,
            hoverColor: Colors.grey,
            child: Container(
              width: 50,
              height: 50,
              child: Icon(Icons.person, size: 30, color: WHITE),
            ),
          ),
          SizedBox(width: 20,),
          InkWell(
            onTap: (){
              widget.homePresenter.goToCartDetail(context);
            },
            focusColor: Colors.grey,
            hoverColor: Colors.grey,
            child: Container(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Icon(Icons.shopping_cart, size: 30, color: WHITE),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: textView('0', WHITE, 18, FontWeight.normal),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}