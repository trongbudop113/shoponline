import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/item_view/item_cart.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/presenter/cart/shop_cart_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
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
  List<CartItem> listCartItem = new List();
  var _firebaseAuth = FirebaseAuth.instance;

  Future<void> getListCart() async{
    onShowProgressDialog();
    Firestore store = firestore();
    CollectionReference ref = store.collection(DatabaseCollection.ALL_CART);
    var document = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
    document.onSnapshot.listen((querySnapshot) {
      querySnapshot.docChanges().forEach((change) {
        if (change.type == "added") {
          Map<String, dynamic> a = change.doc.data();
          var item = CartItem.fromJson(a);
          print(item.name);
          listCartItem.add(item);
        }
      });
    });
    onGetDataSuccess();
  }

  @override
  void initState() {
    shopCartPresenter = new ShopCartPresenter(this);
    getListCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;
    var itemWidthCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeightCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

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
              getListCart();
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
                ItemCartBody(itemHeight: itemHeightCustom, itemWidth: itemWidthCustom, cartItem: listCartItem[index], shopCartPresenter: shopCartPresenter),
              childCount: listCartItem.length,
            )
        )
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: BLACK,
      ),
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
  void onDeleteSuccess() {

  }
}