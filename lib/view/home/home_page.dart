import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/cart_page.dart';
import 'package:flutter_project/view/favorite_page.dart';
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
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(height: itemHeight * 0.03, width: itemWidth, homePresenter: homePresenter),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BannerPage(),
          ),
          SliverToBoxAdapter(
            child: BodyPage(),
          ),
          SliverToBoxAdapter(
            child: FooterPage(),
          )
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: BLACK,
      //   height: 60,
      // ),
    );
  }

  @override
  void goToCartDetail() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CartPage()
    ));
  }

  @override
  void goToWishList() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => FavoritePage()
    ));
  }

  @override
  Future<void> goToLogin() async {
    var result = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
    if(result.toString() == 'reload'){

    }
  }

  @override
  Future<void> showMessageError(String message, BuildContext buildContext) async {
    await showDialog(
      context: buildContext,
      builder: (_) => ShowLoginDialog(title: "Login....", msg: message),
    );
  }

  @override
  void goToPerson() {

  }
}

class CustomAppBar extends PreferredSize {
  final double height;
  final double width;
  final HomePresenter homePresenter;

  CustomAppBar({this.height, this.width, this.homePresenter});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: HeaderPage(homePresenter: homePresenter),
    );
  }
}