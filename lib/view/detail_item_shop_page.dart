import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_project/api/body_right_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/dialog/progress_dialog.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/favorite_notifier.dart';
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
    bodyRightNotifier.currentColor = bodyRightNotifier.currentProduct.colors[0];
    bodyRightNotifier.currentSize = bodyRightNotifier.currentProduct.sizes[0];
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
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);

    Widget getImage(bool isPort){
      return Column(
        children: [
          Container(
            width: isPort ? itemWidth : 650,
            height: isPort ? itemWidth : 650,
            child: customImageView('https://giayxshop.vn/wp-content/uploads/2019/02/MG_4329.jpg'),
          ),
          Container(
            width: isPort ? itemWidth : 650,
            height: 100,
            child: ListView.builder(
              itemCount: 10,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    width: 100,
                    height: 100,
                    child: Container(
                      child: customImageView('https://giayxshop.vn/wp-content/uploads/2019/02/MG_4329.jpg'),
                    ),
                  ),
                  onTap: (){
                    bodyRightNotifier.currentColor = bodyRightNotifier.currentProduct.colors[index];
                  },
                );
              },
            ),
          )
        ],
      );
    }

    Widget getNameProduct(){
      return SliverToBoxAdapter(
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
      );
    }

    Widget divider(){
      return SliverToBoxAdapter(
        child: Divider(color: Colors.grey, height: 1),
      );
    }

    Widget getColorList(){
      return SliverToBoxAdapter(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: itemWidth  * 0.05, vertical: 10),
                  child: Row(
                    children: [
                      textView('Màu sắc:', BLACK, 15, FontWeight.normal),
                      SizedBox(width: 20),
                      Container(
                        width: itemWidth * 0.7,
                        height: 45,
                        child: ListView.builder(
                          itemCount: bodyRightNotifier.currentProduct.colors.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0),
                                padding: EdgeInsets.all(5.0),
                                width: 45,
                                height: 40,
                                color: bodyRightNotifier.currentColor == bodyRightNotifier.currentProduct.colors[index] ? BLACK : Colors.transparent,
                                child: Container(
                                  color: Color(int.parse(bodyRightNotifier.currentProduct.colors[index].toString())),
                                ),
                              ),
                              onTap: (){
                                bodyRightNotifier.currentColor = bodyRightNotifier.currentProduct.colors[index];
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey, height: 1),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: itemWidth  * 0.05, vertical: 10),
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        textView('Size:', BLACK, 15, FontWeight.normal),
                        SizedBox(width: 20),
                        Container(
                          width: itemWidth * 0.7,
                          height: 45,
                          child: ListView.builder(
                            itemCount: bodyRightNotifier.currentProduct.sizes.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 5.0),
                                width: 55,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1)
                                ),
                                child: textView(bodyRightNotifier.currentProduct.sizes[index].toString(), BLACK, 18, FontWeight.normal),
                              );
                            },
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

    Widget getDetail(){
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(itemWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textView('Thông tin chi tiết:', BLACK, 20, FontWeight.normal),
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
      );
    }

    return Scaffold(
      appBar: AppBarCart(heightAppbar: heightAppbar, appbarPresenter: appbarPresenter),
      body: ModalProgressHUD(
        inAsyncCall: cartNotifier.currentLoading,
        child: !Common.isPortrait(context) ?
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: getImage(false),
                    margin: EdgeInsets.all(50),
                  ),
                  Container(

                  )
                ],
              ),
            ),
            getNameProduct(),
            divider(),
            getColorList(),
            divider(),
            getDetail()
          ],
        ) :
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: getImage(true),
            ),
            getNameProduct(),
            divider(),
            getColorList(),
            divider(),
            getDetail()
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
              child: textView('${Common.getCurrencyFormat(bodyRightNotifier.currentProduct.price)} VND', WHITE, 20, FontWeight.normal),
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
    FavoriteNotifier favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: false);
    addToWishList(authNotifier, bodyRightNotifier, _itemCount, cartPresenter, favoriteNotifier);
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