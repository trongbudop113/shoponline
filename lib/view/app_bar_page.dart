import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/presenter/app_bar_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/values/string_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';

class AppBarCart extends PreferredSize {
  final AppbarPresenter appbarPresenter;
  final double heightAppbar;

  AppBarCart({this.appbarPresenter, this.heightAppbar});

  @override
  Size get preferredSize => Size.fromHeight(heightAppbar);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: AppBarPage(context: context, appbarPresenter: appbarPresenter),
    );
  }
}

class AppBarPage extends StatelessWidget {

  AppBarPage({Key key, this.context, this.appbarPresenter}) : super(key: key);
  final BuildContext context;
  final AppbarPresenter appbarPresenter;

  Future<void> goToCartPage() async {
    if((await _connectivity.checkConnectivity()).toString() != "ConnectivityResult.none") {
      appbarPresenter.checkLoginGoToCart();
    }else{
      appbarPresenter.showMessageError(PageName.network, context);
    }
  }

  final Connectivity _connectivity = new Connectivity();
  var sizeTextCustom = 28.0;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: BLACK,
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(width: 5),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: 50,
            height: 50,
            child: Container(
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back, size: 30, color: WHITE),
            ),
          ),
        ),
        Spacer(flex: 1,),
        Container(
          alignment: Alignment.center,
          child: textViewCenter('WEARISM', WHITE, sizeTextCustom, FontWeight.bold),
        ),
        Spacer(flex: 1,),
        InkWell(
          onTap: (){
            goToCartPage();
          },
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
        ),
        SizedBox(width: 15)
      ],
    );
  }
}

class AppBarNormal extends PreferredSize {
  final double heightAppbar;

  AppBarNormal({this.heightAppbar});

  @override
  Size get preferredSize => Size.fromHeight(heightAppbar);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: AppBarNormalPage(context: context)
    );
  }
}

class AppBarNormalPage extends StatelessWidget {

  AppBarNormalPage({Key key, this.context}) : super(key: key);
  final BuildContext context;

  var sizeTextCustom = 28.0;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: BLACK,
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(width: 10),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: 50,
            height: 50,
            child: Container(
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back, size: 30, color: WHITE),
            ),
          ),
        ),
        Spacer(flex: 1,),
        Container(
          alignment: Alignment.center,
          child: textViewCenter('WEARISM', WHITE, sizeTextCustom, FontWeight.bold),
        ),
        Spacer(flex: 1,),
        Container(
            width: 50,
            height: 50,
        ),
        SizedBox(width: 15)
      ],
    );
  }
}

class AppBarProfile extends PreferredSize {
  final double heightAppbar;
  final AppbarPresenter appbarPresenter;
  final AuthNotifier authNotifier;

  AppBarProfile({this.heightAppbar, this.appbarPresenter, this.authNotifier});

  @override
  Size get preferredSize => Size.fromHeight(heightAppbar);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: preferredSize.height,
        child: AppBarProfilePage(context: context, appbarPresenter: appbarPresenter, authNotifier: authNotifier)
    );
  }
}

class AppBarProfilePage extends StatelessWidget {

  AppBarProfilePage({Key key, this.context, this.appbarPresenter, this.authNotifier}) : super(key: key);
  final BuildContext context;
  final AppbarPresenter appbarPresenter;
  final AuthNotifier authNotifier;

  var sizeTextCustom = 28.0;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: BLACK,
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(width: 10),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: 50,
            height: 50,
            child: Container(
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back, size: 30, color: WHITE),
            ),
          ),
        ),
        Spacer(flex: 1,),
        Container(
          alignment: Alignment.center,
          child: textViewCenter('WEARISM', WHITE, sizeTextCustom, FontWeight.bold),
        ),
        Spacer(flex: 1,),
        InkWell(
          child: Container(
            width: 50,
            height: 50,
            child: Icon(Icons.logout, size: 30, color: WHITE),
          ),
          onTap: (){
            appbarPresenter.handleLogoutApp(authNotifier);
          },
        ),
        SizedBox(width: 15)
      ],
    );
  }
}