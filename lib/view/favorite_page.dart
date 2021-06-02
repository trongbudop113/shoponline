import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/model/favorite.dart';
import 'package:flutter_project/presenter/app_bar_presenter.dart';
import 'package:flutter_project/presenter/favorite/favorite_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/app_bar_page.dart';
import 'package:flutter_project/view/cart_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> implements FavoriteContract, AppbarContract {

  FavoritePresenter favoritePresenter;
  AppbarPresenter appbarPresenter;
  double heightAppbar = 0.0;

  @override
  void initState() {
    favoritePresenter = new FavoritePresenter(this);
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

    Widget yourWishList(){
      return SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
            child: textView('Danh sách yêu thích của bạn:', BLACK, 22, FontWeight.normal),
          )
      );
    }


    Widget spaceHeight(double space){
      return SliverToBoxAdapter(
        child: SizedBox(height: itemHeight * space),
      );
    }

    Widget listCart(bool isPortrait){
      return SliverPadding(
          padding: isPortrait ? EdgeInsets.symmetric(horizontal: itemWidth * 0.05) : EdgeInsets.all(itemWidth * 0.05),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) =>
                  Container(
                    color: BLACK,
                  ),
                childCount: 5,
              )
          )
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBarCart(heightAppbar: heightAppbar, appbarPresenter: appbarPresenter),
        body: Container(
          width: itemWidth,
          child: !Common.isPortrait(context) ?
          Container(
            child: Row(
              children: [
                Container(
                  width: itemWidth * 0.6,
                  height: itemHeight,
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      spaceHeight(0.02),
                      yourWishList(),
                      spaceHeight(0.02),
                      listCart(true),
                      spaceHeight(0.02),
                    ],
                  ),
                ),
                Container(
                  width: itemWidth * 0.4,
                  height: itemHeight,
                  child: CustomScrollView(
                    slivers: [
                      spaceHeight(0.1),
                    ],
                  ),
                )
              ],
            ),
          ) :
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              spaceHeight(0.02),
              yourWishList(),
              listCart(false),
              spaceHeight(0.05),
            ],
          ),
        )

    );
  }

  @override
  void onDeleteSuccess() {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onGetDataSuccess() {
    // TODO: implement onGetDataSuccess
  }

  @override
  void onHideProgressDialog() {
    // TODO: implement onHideProgressDialog
  }

  @override
  void onShowProgressDialog() {
    // TODO: implement onShowProgressDialog
  }

  @override
  void onUpdateSuccess(FavoriteItem favoriteItem) {
    // TODO: implement onUpdateSuccess
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {
    // TODO: implement showMessageError
  }

  @override
  void goToCartPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CartPage()
    ));
  }

  @override
  void showDialogLogin(String message) {

  }

  @override
  void goToFavoritePage() {

  }

  @override
  void logoutApp() {

  }
}