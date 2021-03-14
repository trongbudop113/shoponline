import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/presenter/home/cart_presenter.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:toast/toast.dart';

class ItemBodyRight extends StatefulWidget {
  ItemBodyRight({Key key, this.item, this.menuLeftPresenter}) : super(key: key);
  final BodyRight item;
  final MenuLeftPresenter menuLeftPresenter;

  @override
  _ItemBodyRightState createState() => _ItemBodyRightState();
}

class _ItemBodyRightState extends State<ItemBodyRight> implements CartContract  {

  int _itemCount = 0;
  CartPresenter cartPresenter;
  bool isHover = false;

  @override
  void initState() {
    cartPresenter = new CartPresenter(this);
    super.initState();
  }

  void onClickAddToCart(BodyRight item) {
    CartItem cart = new CartItem();
    cart.quantity = _itemCount;
    cart.id = item.id;
    cart.name = item.name;
    cart.image = item.image;
    cart.discount = item.discount;
    cart.price = item.price;
    widget.menuLeftPresenter.checkLoginToAddToCart(cart, cartPresenter);
  }

  void onClickAddToWishList(BodyRight item) {
    CartItem cart = new CartItem();
    cart.quantity = _itemCount;
    cart.id = item.id;
    cart.name = item.name;
    cart.image = item.image;
    cart.discount = item.discount;
    cart.price = item.price;
    widget.menuLeftPresenter.checkLoginToAddToWishList(cart, cartPresenter);
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    var widthTextDisCount = (itemWidth * 0.02) > 35 ? itemWidth * 0.02 : 35;
    var sizeTextDisCount = 10.0;
    var sizeTextName = (itemWidth * 0.01) > 14 ? itemWidth * 0.01 : 14;
    var widthButton = (itemWidth * 0.05) > 50 ? (itemWidth * 0.05) : 50;
    var sizeButton = (itemWidth * 0.02) > 20 ? (itemWidth * 0.02) : 20;

    Widget itemButton(IconData icon, int type){
      return InkWell(
        child: Container(
          width: widthButton,
          height: widthButton,
          color: BLACK,
          child: Icon(icon, color: WHITE, size: sizeButton),
        ),
        onTap: (){
          switch(type){
            case 1 : {
              onClickAddToCart(widget.item);
              break;
            }
            case 0 : {
              onClickAddToWishList(widget.item);
              break;
            }
          }
        },
      );
    }

    return InkWell(
      onHover: (value){
        setState(() {
          isHover = value;
        });
      },
      onTap: (){
        widget.menuLeftPresenter.goToDetail(widget.item);
      },
      child: Container(
          child: CachedNetworkImage(
            imageUrl: widget.item.image,
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
                      child: widget.item.discount == '0' ?
                      Container() :
                      Container(
                        color: BLACK,
                        width: widthTextDisCount,
                        height: widthTextDisCount,
                        alignment: Alignment.center,
                        child: textView('-' + widget.item.discount + '%', WHITE, sizeTextDisCount, FontWeight.normal),
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
                            child: textView( widget.item.name, WHITE, sizeTextName, FontWeight.bold),
                          ),
                          Container(
                            child: textView(widget.item.price, WHITE, sizeTextName, FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  isHover ?
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            itemButton(Icons.favorite, 0),
                            SizedBox(width: 5,),
                            itemButton(Icons.add_shopping_cart, 1)
                          ],
                        ),
                      ],
                    )
                  ) :
                  Container(),
                ],
              )
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
      ),
    );
  }

  @override
  void onAddToCartSuccess(CartItem bodyRight) {
    setState(() {
      _itemCount = 0;
    });
    final snackBar = SnackBar(content: Text(bodyRight.name + ' added To Cart'), duration: Duration(seconds: 1));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void onAddToWishListExist(String message) {
    Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  @override
  void onAddToWishListSuccess(CartItem bodyRight) {
    final snackBar = SnackBar(content: Text(bodyRight.name + ' added To Wish List'), duration: Duration(seconds: 1));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}