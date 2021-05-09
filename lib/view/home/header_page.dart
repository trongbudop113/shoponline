
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends PreferredSize {
  final HomePresenter homePresenter;
  final double heightAppbar;

  CustomAppBar({this.homePresenter, this.heightAppbar});

  @override
  Size get preferredSize => Size.fromHeight(heightAppbar);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: AppBarPage(context: context, homePresenter: homePresenter),
    );
  }
}

class AppBarPage extends StatelessWidget {
  AppBarPage({Key key, this.context, this.homePresenter}) : super(key: key);
  final BuildContext context;
  final HomePresenter homePresenter;

  Future<void> goToCheckOutPage() async {
    if((await _connectivity.checkConnectivity()).toString() != "ConnectivityResult.none") {

    }else{

    }
  }

  Future<void> goToNotificationPage() async {
    if((await _connectivity.checkConnectivity()).toString() != "ConnectivityResult.none") {

    }else{

    }
  }

  final Connectivity _connectivity = new Connectivity();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BLACK,
      actions: [
        HeaderPage(homePresenter: homePresenter)
      ],
    );
  }
}

class HeaderPage extends StatefulWidget {
  HeaderPage({Key key,this.homePresenter}) : super(key: key);
  final HomePresenter homePresenter;

  @override
  State<StatefulWidget> createState() {
    return _HeaderPageState();
  }
}

class _HeaderPageState extends State<HeaderPage> {

  var _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    getCountCart(authNotifier, cartNotifier);
    super.initState();
  }

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
      width: MediaQuery.of(context).size.width,
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
                      child: textView('${context.watch<AuthNotifier>().count.toString()}', WHITE, 18, FontWeight.normal),
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