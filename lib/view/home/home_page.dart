import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/view/home/banner_page.dart';
import 'package:flutter_project/view/home/body_page.dart';
import 'package:flutter_project/view/home/footer_page.dart';
import 'package:flutter_project/view/home/header_page.dart';
import 'package:flutter_project/view/login_page.dart';
import 'package:flutter_project/widget/dialog_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeContract {

  HomePresenter homePresenter;

  @override
  void initState() {
    homePresenter = new HomePresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(height: itemHeight * 0.05, width: itemWidth * 0.08, homePresenter: homePresenter),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.08),
            child: Column(
              children: [
                SizedBox(height: 20,),
                BannerPage(),
                SizedBox(height: 30,),
                BodyPage(),
                SizedBox(height: 20,),
                FooterPage(),
                SizedBox(height: 20,)
              ],
            ),
          ),
        )
    );
  }

  @override
  void goToCartDetail() {

  }

  @override
  void goToWishList() {

  }

  @override
  void goToLogin() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
  }

  @override
  Future<void> showMessageError(String message, BuildContext buildContext) async {
    await showDialog(
      context: buildContext,
      builder: (_) => ShowLoginDialog(title: "Login....", msg: message),
    );
  }
}

class CustomAppBar extends PreferredSize {
  final double height;
  final double width;
  final HomePresenter homePresenter;

  CustomAppBar({this.height, this.width, this.homePresenter});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      margin: EdgeInsets.symmetric(horizontal: width),
      child: HeaderPage(homePresenter: homePresenter),
    );
  }
}