import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemBodyRight extends StatefulWidget {
  ItemBodyRight({Key key, this.item, this.menuLeftPresenter}) : super(key: key);
  final BodyRight item;
  final MenuLeftPresenter menuLeftPresenter;

  @override
  _ItemBodyRightState createState() => _ItemBodyRightState();
}

class _ItemBodyRightState extends State<ItemBodyRight> {

  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      width: 100,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      child: CachedNetworkImage(
        imageUrl: widget.item.image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
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
                      IconButton(icon: new Icon(Icons.add_shopping_cart, size: itemWidth* 0.015),onPressed: (){
                        CartItem cart = new CartItem();
                        cart.quantity = 3;
                        cart.id = widget.item.id;
                        cart.name = widget.item.name;
                        cart.image = widget.item.image;
                        cart.discount = widget.item.discount;
                        cart.price = widget.item.price;
                        widget.menuLeftPresenter.addToCart(cart);
                      })
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
}