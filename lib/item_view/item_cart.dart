import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/presenter/cart/shop_cart_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/image_widget.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemCartBody extends StatefulWidget{

  final double itemWidth;
  final double itemHeight;
  final CartItem cartItem;
  final ShopCartPresenter shopCartPresenter;
  ItemCartBody({Key key, this.itemWidth, this.itemHeight, this.cartItem, this.shopCartPresenter}) : super(key: key);

  @override
  _ItemCartBody createState() => _ItemCartBody();

}

class _ItemCartBody extends State<ItemCartBody>{

  var textSize = 22.0;
  var _itemCount = 0;

  @override
  void initState() {
    super.initState();
    _itemCount = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: widget.itemWidth * 0.02, vertical: widget.itemHeight * 0.05),
            color: BLACK,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: widget.itemWidth * 0.02),
                      width: widget.itemWidth * 0.15,
                      height: widget.itemWidth * 0.15,
                      child: customImageView(widget.cartItem.image),
                    ),
                    Spacer(flex: 1),
                    Container(
                      child: GestureDetector(
                        child: Icon(Icons.favorite, color: WHITE, size: widget.itemWidth * 0.05),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.itemHeight * 0.03),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: widget.itemWidth * 0.02),
                      child: textView(widget.cartItem.name, WHITE, 30, FontWeight.bold),
                    ),
                    Spacer(flex: 1,),
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            child: textView('-', WHITE, textSize, FontWeight.normal),
                            onTap: (){
                              setState(() {
                                _itemCount <= 1 ? 1 : _itemCount--;
                              });
                              updateQuantityCart(_itemCount);
                            },
                          ),
                          SizedBox(width: 12,),
                          textViewCenter(_itemCount.toString(), WHITE, textSize, FontWeight.bold),
                          SizedBox(width: 12,),
                          GestureDetector(
                            child: textView('+', WHITE, textSize, FontWeight.normal),
                            onTap: (){
                              setState(() {
                                _itemCount++;
                              });
                              updateQuantityCart(_itemCount);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: widget.itemHeight * 0.03),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(Icons.delete, color: WHITE),
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: textView('Remove this item', WHITE, 12, FontWeight.normal),
                      )
                    ],
                  ),
                )
              ],
            )
        ),
        Divider(height: 2, color: WHITE)
      ],
    );
  }

  void updateQuantityCart(int itemCount){
    widget.shopCartPresenter.updateQuantityCart(itemCount, widget.cartItem, context);
  }
}