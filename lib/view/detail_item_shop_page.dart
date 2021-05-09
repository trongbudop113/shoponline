import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_project/api/body_right_api.dart';
import 'package:flutter_project/dialog/progress_dialog.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/presenter/app_bar_presenter.dart';
import 'package:flutter_project/presenter/home/cart_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/app_bar_page.dart';
import 'package:flutter_project/view/cart_page.dart';
import 'package:flutter_project/widget/image_widget.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ItemDetailPage extends StatefulWidget {
  ItemDetailPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> implements CartContract, AppbarContract {

  bool _isShow = false;
  BodyRightNotifier bodyRightNotifier;
  AuthNotifier authNotifier;
  CartPresenter cartPresenter;
  AppbarPresenter appbarPresenter;

  int _itemCount = 1;
  double heightAppbar = 0.0;

  @override
  void initState() {
    cartPresenter = new CartPresenter(this);
    appbarPresenter = new AppbarPresenter(this);
    bodyRightNotifier = Provider.of<BodyRightNotifier>(context, listen: false);
    authNotifier = Provider.of<AuthNotifier>(context, listen: false);
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

    return Scaffold(
      appBar: AppBarCart(heightAppbar: heightAppbar, appbarPresenter: appbarPresenter),
      body: ModalProgressHUD(
        inAsyncCall: _isShow,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: itemWidth,
                height: itemWidth,
                child: customImageView('https://giayxshop.vn/wp-content/uploads/2019/02/MG_4329.jpg'),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(itemWidth * 0.05),
                      alignment: Alignment.center,
                      width: itemWidth * 0.6,
                      child: textView('${bodyRightNotifier.currentProduct.name}', BLACK, 20, FontWeight.normal),
                    ),
                    Container(
                      padding: EdgeInsets.all(itemWidth * 0.05),
                      alignment: Alignment.center,
                      width: itemWidth * 0.4,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              child: textView('-', WHITE, 18, FontWeight.normal),
                              color: BLACK,
                              width: 30,
                              height: 30,
                            ),
                            onTap: (){
                              setState(() {
                                _itemCount <= 1 ? _itemCount = 1 : _itemCount--;
                              });
                            },
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: textViewCenter('${_itemCount.toString()}', BLACK, 18, FontWeight.normal),
                            width: 40,
                            height: 30,
                          ),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              child: textView('+', WHITE, 18, FontWeight.normal),
                              color: BLACK,
                              width: 30,
                              height: 30,
                            ),
                            onTap: (){
                              setState(() {
                                _itemCount++;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(color: Colors.grey, height: 1),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: itemWidth  * 0.05, vertical: 10),
                      width: itemWidth * 0.5 - 1,
                      child: Row(
                        children: [
                          textView('Màu sắc:', BLACK, 15, FontWeight.normal),
                          Spacer(flex: 1),
                          Container(
                            width: 40,
                            height: 40,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: itemHeight * 0.05,
                      child: VerticalDivider(color: Colors.grey, width: 1)
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: itemWidth  * 0.05, vertical: 10),
                      width: itemWidth * 0.5,
                      child: Row(
                        children: [
                          textView('Size:', BLACK, 15, FontWeight.normal),
                          Spacer(flex: 1),
                          textView('31.5', BLACK, 18, FontWeight.normal),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
            SliverToBoxAdapter(
              child: Divider(color: Colors.grey, height: 1),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(itemWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textView('Thông tin chi tiết', BLACK, 20, FontWeight.normal),
                    SizedBox(height: itemHeight * 0.01),
                    textViewLine('${bodyRightNotifier.currentProduct.description.toString()}',
                        Colors.grey,
                        15,
                        FontWeight.normal,
                        1.5
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        progressIndicator: IndicatorProgress(),
      ),
      bottomNavigationBar: Container(
        color: BLACK,
        width: itemWidth,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: (itemWidth * 0.4) - 1,
              child: textView('${bodyRightNotifier.currentProduct.price.toString()} VND', WHITE, 20, FontWeight.normal),
            ),
            Spacer(flex: 1,),
            Container(
              height: 60,
              child: VerticalDivider(color: WHITE, width: 1),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: itemWidth * 0.2,
                child: Container(
                  child: Icon(Icons.favorite, color: WHITE, size: 30),
                ),
              ),
              onTap: (){
                cartPresenter.checkLoginToAddToWishList();
              },
            ),
            Container(
              height: 60,
              child: VerticalDivider(color: WHITE, width: 1),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: itemWidth * 0.2,
                child: Container(
                  child: Icon(Icons.shopping_bag, color: WHITE, size: 30),
                ),
              ),
              onTap: (){
                cartPresenter.checkLoginToAddToCart();
              },
            )
          ],
        ),
      )
    );
  }

  @override
  onAddToCartSuccess(CartItem bodyRight) {
    setState(() {
      _itemCount = 1;
    });
    Toast.show(bodyRight.name + ' added To Cart', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  @override
  onAddToWishListExist(String message) {
    Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  @override
  onAddToWishListSuccess(BodyRight bodyRight) {
    Toast.show(bodyRight.name + ' added To Wish List', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  @override
  void showDialogLogin(String message) {

  }

  @override
  void actionAddToCart() {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    addToCart(authNotifier, bodyRightNotifier, _itemCount, cartPresenter, cartNotifier);
  }

  @override
  void actionAddToWishList() {
    addToWishList(authNotifier, bodyRightNotifier, _itemCount, cartPresenter);
  }

  @override
  void goToCartPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CartPage()
    ));
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {
    print('aaaaaaa');
  }
}