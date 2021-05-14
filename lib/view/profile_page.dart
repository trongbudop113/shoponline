import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/favorite_notifier.dart';
import 'package:flutter_project/presenter/app_bar_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/app_bar_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> implements AppbarContract {

  AppbarPresenter appbarPresenter;
  double heightAppbar = 0.0;
  AuthNotifier authNotifier;

  @override
  void initState() {
    authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    getUserData(authNotifier);
    appbarPresenter = new AppbarPresenter(this);
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

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    Widget widgetAvatar(double width, double height){
      return SliverToBoxAdapter(
        child: Container(
          width: width,
          height: height,
          color: Colors.grey[500],
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                left: 15.0,
                child: Container(
                  width: itemWidth * 0.3,
                  height: itemWidth * 0.3,
                  color: BLACK,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarCart(appbarPresenter: appbarPresenter, heightAppbar: heightAppbar),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.grey[300],
              Colors.grey[400],
              Colors.grey[500],
              Colors.grey[600],
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: itemWidth,
                height: itemHeight - heightAppbar,
                padding: EdgeInsets.all(itemWidth * 0.05),
                child: Column(
                  children: [
                    Spacer(flex: 1,),
                    Container(
                      height: 600,
                      child: Stack(
                        children: [
                          Positioned(
                            top: (itemHeight - (itemWidth * 0.1)) * 0.07,
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: (itemHeight - (itemWidth * 0.1)) * 0.12,
                                      child: Row(
                                        children: [
                                          Spacer(flex: 1,),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  textView(context.watch<FavoriteNotifier>().favoriteCount.toString(), BLACK, 20, FontWeight.bold),
                                                  Icon(Icons.favorite, color: BLACK, size: 35),
                                                ],
                                              ),
                                              textView('Favorite', BLACK, 10, FontWeight.bold),
                                            ],
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  textView(context.watch<AuthNotifier>().count.toString(), BLACK, 20, FontWeight.bold),
                                                  Icon(Icons.shopping_cart, color: BLACK, size: 35)
                                                ],
                                              ),
                                              textView('Your cart', BLACK, 10, FontWeight.bold),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    textView('${authNotifier.userData.name}', BLACK, 25, FontWeight.bold),
                                    SizedBox(height: 15),
                                    textView('Phone: ${authNotifier.userData.phone}', BLACK, 20, FontWeight.bold),
                                    SizedBox(height: 5),
                                    textView('Birthday : ${authNotifier.userData.birthDay}', BLACK, 20, FontWeight.bold),
                                    SizedBox(height: 5),
                                    textView('Gender : ${authNotifier.userData.gender}', BLACK, 20, FontWeight.bold),
                                    SizedBox(height: 5),
                                    textView('Address : ${authNotifier.userData.address}', BLACK, 20, FontWeight.bold),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            left: itemWidth * 0.05,
                            child: Container(
                              width: 150,
                              height: 150,
                              color: BLACK,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  void goToCartPage() {

  }

  @override
  void showDialogLogin(String message) {

  }

  @override
  void showMessageError(String message, BuildContext buildContext) {

  }
}