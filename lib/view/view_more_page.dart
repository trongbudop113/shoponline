
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/dialog/accept_dialog.dart';
import 'package:flutter_project/dialog/error_dialog.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/menu_left_notifier.dart';
import 'package:flutter_project/presenter/app_bar_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/app_bar_page.dart';
import 'package:flutter_project/view/cart_page.dart';
import 'package:flutter_project/view/detail_item_shop_page.dart';
import 'package:flutter_project/view/login_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ViewMorePage extends StatefulWidget {
  ViewMorePage({Key key}) : super(key: key);

  @override
  _ViewMorePageState createState() => _ViewMorePageState();
}

class _ViewMorePageState extends State<ViewMorePage> implements AppbarContract {

  AppbarPresenter appbarPresenter;
  var sizeTextCustom = 28.0;
  double heightAppbar = 0.0;


  @override
  void initState() {
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
    MenuLeftNotifier menuLeftNotifier = Provider.of<MenuLeftNotifier>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightAppbar),
        child: AppBar(
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
              child: textViewCenter('${menuLeftNotifier.currentCategory.name}', WHITE, sizeTextCustom, FontWeight.bold),
            ),
            Spacer(flex: 1,),
            InkWell(
              onTap: (){
                appbarPresenter.checkLoginGoToCart();
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
        ),
      ),
      body: ItemTabbarView()
    );
  }

  @override
  void goToCartPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CartPage()
    ));
  }

  @override
  void goToFavoritePage() {
    // TODO: implement goToFavoritePage
  }

  @override
  void logoutApp() {
    // TODO: implement logoutApp
  }

  @override
  Future<void> showDialogLogin(String message) async {
    var a  = await showDialog(
      context: context,
      builder: (_) => AcceptDialog(title: 'Thông báo', msg: message),
    );
    if(a.toString() == 'Yes'){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => LoginPage()
      ));
    }
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {
    showDialog(
      context: context,
      builder: (_) => ErrorDialog(title: 'Thông báo', msg: message),
    );
  }
}

class ItemTabbarView extends StatefulWidget {
  ItemTabbarView({Key key, this.menuLeft}) : super(key: key);
  final MenuLeft menuLeft;

  @override
  _ItemTabbarViewState createState() => _ItemTabbarViewState();
}

class _ItemTabbarViewState extends State<ItemTabbarView> {

  @override
  void initState() {
    BodyRightNotifier bodyRightNotifier = Provider.of<BodyRightNotifier>(context, listen: false);
    getProductsData(bodyRightNotifier, widget.menuLeft);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemWidthCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;
    var sizeTextName = (itemWidth * 0.01) > 14 ? itemWidth * 0.01 : 14;

    BodyRightNotifier bodyRightNotifier = Provider.of<BodyRightNotifier>(context, listen: false);

    return GridView.count(
      crossAxisCount: Common.isPortrait(context) ? 2 : 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: EdgeInsets.all(4.0),
      childAspectRatio: 3 / 4,
      children: bodyRightNotifier.productList.map(
            (item) => InkWell(
              child: Card(
                  elevation: 5.0,
                  child: CachedNetworkImage(
                      imageUrl: item.image,
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: BLACK),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.all(itemWidth * 0.01),
                                  child: item.discount == '0' ?
                                  Container() :
                                  Container(
                                    color: BLACK,
                                    alignment: Alignment.center,
                                    child: textView('-' + item.discount + '%', WHITE, 10.0, FontWeight.normal),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: BLACK,
                                  padding: EdgeInsets.all(itemWidth* 0.01),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: textView(item.name, WHITE, sizeTextName, FontWeight.bold),
                                      ),
                                      Container(
                                        child: textView(item.price, WHITE, sizeTextName, FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: BLACK),
                          ),
                          child: Icon(Icons.error),
                        );
                      }
                  )
              ),
              onTap: (){
                bodyRightNotifier.currentProduct = item;
                goToDetail();
              },
            ),
      ).toList(),
    );
  }

  void goToDetail() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return ItemDetailPage();
    }));
  }
}