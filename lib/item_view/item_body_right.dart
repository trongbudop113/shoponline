import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/presenter/home/cart_presenter.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/values/string_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
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
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(itemWidth* 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widget.item.discount == '0' ? Container() : Container(
                        width: itemWidth * 0.02,
                        height: itemWidth * 0.02,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            border: Border.all(color: Colors.purple[200])
                        ),
                        child: textView(widget.item.discount + '%', Colors.purple[200], itemWidth * 0.008, FontWeight.bold),
                      ),
                      Spacer(flex: 1),
                      IconButton(icon: new Icon(Icons.favorite, size: itemWidth* 0.015),onPressed: ()=>setState((){}))
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(itemWidth* 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: new Icon(Icons.remove_circle_outline),onPressed: ()=>setState(() => _itemCount > 0 ? _itemCount -- : 0)),
                      textView(_itemCount.toString(), Colors.purple[200], 18, FontWeight.bold),
                      IconButton(icon: new Icon(Icons.add_circle_outline_rounded),onPressed: ()=>setState(()=>_itemCount >= 0 ? _itemCount ++ : 0)),
                      Spacer(flex: 1),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          bool isLogin = prefs.getBool(Common.LOGIN) ?? false;
                          if(isLogin){
                            _itemCount == 0 ?
                            widget.menuLeftPresenter.showToastMessage(PageName.CHOOSE_ITEM) :
                            onClickAddToCart(widget.item);
                          }else{

                          }
                        },
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        child: Container(
                          width: itemWidth* 0.015,
                          height: itemWidth* 0.015,
                          child: Icon(Icons.add_shopping_cart),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      )
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
}