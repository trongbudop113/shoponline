import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_project/api/cart_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/item_view/item_cart.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/presenter/cart/shop_cart_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/app_bar_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> implements ShopCartContract {

  TextEditingController codeTextController = TextEditingController();
  var textSize = 22.0;

  ShopCartPresenter shopCartPresenter;
  double heightAppbar = 0.0;

  @override
  void initState() {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    getListCartData(cartNotifier);
    shopCartPresenter = new ShopCartPresenter(this);
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
    var itemWidthCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeightCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);

    Widget _entryFieldText(TextEditingController textController, TextInputType inputType) {
      return TextField(
          keyboardType: inputType,
          controller: textController,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            focusColor: Colors.white,
            fillColor: Colors.white,
            enabledBorder: new OutlineInputBorder(
              borderSide: BorderSide(
                width: 0
              ),
            ),
            focusedBorder : new OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            filled: true,
          )
      );
    }

    Widget yourCart(){
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
          child: textView('Giỏ hàng của bạn:', BLACK, 22, FontWeight.normal),
        )
      );
    }

    Widget codeBox(double needWidth){
      return SliverToBoxAdapter(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: needWidth * 0.6,
                  child: _entryFieldText(codeTextController, TextInputType.text),
                ),
                Spacer(flex: 1),
                Container(
                  color: BLACK,
                  width: needWidth * 0.2,
                  height: 50,
                  alignment: Alignment.center,
                  child: textViewCenter('Apply', WHITE, 20, FontWeight.normal),
                )
              ],
            )
        ),
      );
    }

    Widget totalPayment(){
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              textView('Thành tiền: ' + '100.000', BLACK, 20, FontWeight.normal),
              textView('Giảm giá: ' + '20.000', BLACK, 20, FontWeight.normal),
              textView('Tổng: ' + '80.000', BLACK, 20, FontWeight.normal),
            ],
          ),
        ),
      );
    }

    Widget paymentCart(){
      return SliverToBoxAdapter(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(itemWidth * 0.05),
            color: BLACK,
            height: 50,
            child: textView('Thanh toán', WHITE, 20, FontWeight.normal),
          ),
          onTap: (){
            setState(() {
              //getListCart();
            });
          },
        ),
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
                ItemCartBody(itemHeight: itemHeightCustom, itemWidth: itemWidthCustom, cartItem: cartNotifier.cartList[index], shopCartPresenter: shopCartPresenter),
              childCount: cartNotifier.cartList.length,
            )
        )
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBarNormal(heightAppbar: heightAppbar),
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
                    yourCart(),
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
                    totalPayment(),
                    spaceHeight(0.05),
                    codeBox(itemWidth * 0.35),
                    paymentCart(),
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
            yourCart(),
            listCart(false),
            codeBox(itemWidth),
            spaceHeight(0.05),
            totalPayment(),
            paymentCart()
          ],
        ),
      )

    );
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
  void showMessageError(String message, BuildContext buildContext) {
    // TODO: implement showMessageError
  }

  @override
  void onUpdateSuccess(CartItem cartItem) {
    Toast.show(cartItem.name + ' was updated success', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  @override
  void onDeleteSuccess(CartItem cartItem) {
    Toast.show(cartItem.name + ' was removed from cart', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    setState(() {
      //getListCart();
    });
  }
}